-- msgeq7.lua - NodeMCU Library for reading out an msqeq7
-- requires adc and gpio module
-- LUST 20160921

msgeq7 = {

    init = function(self, strobepin, resetpin)
        if adc.force_init_mode(adc.INIT_ADC)
        then
          print("RESTART REQUIRED")
          node.restart() --restart needed for changes to take effect
          return
        end
    
        self.strobe = strobepin
        self.reset = resetpin
        gpio.mode(resetpin, gpio.OUTPUT)
        gpio.mode(strobepin, gpio.OUTPUT)
        gpio.write(resetpin, gpio.LOW)
        gpio.write(strobepin, gpio.LOW)
    end,

    read = function(self)
        gpio.write(self.reset, gpio.HIGH)
        gpio.write(self.reset, gpio.LOW)
        gpio.write(self.strobe, gpio.HIGH)
        gpio.write(self.strobe, gpio.LOW)

        local result = {};
        result[1] = adc.read(0)
        gpio.write(self.strobe, gpio.HIGH)
        gpio.write(self.strobe, gpio.LOW)
        result[2] = adc.read(0)
        gpio.write(self.strobe, gpio.HIGH)
        gpio.write(self.strobe, gpio.LOW)
        result[3] = adc.read(0)
        gpio.write(self.strobe, gpio.HIGH)
        gpio.write(self.strobe, gpio.LOW)
        result[4] = adc.read(0)
        gpio.write(self.strobe, gpio.HIGH)
        gpio.write(self.strobe, gpio.LOW)
        result[5] = adc.read(0)
        gpio.write(self.strobe, gpio.HIGH)
        gpio.write(self.strobe, gpio.LOW)
        result[6] = adc.read(0)
        gpio.write(self.strobe, gpio.HIGH)
        gpio.write(self.strobe, gpio.LOW)
        result[7] = adc.read(0)
        return result
    end
}
