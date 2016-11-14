from abc import ABCMeta, abstractmethod
from structs import MarketData


class Callback(metaclass=ABCMeta):
    '''callback interface'''
    @abstractmethod
    def onMatch(self, data: MarketData):
        '''onMatch'''

    @abstractmethod
    def onReceived(self, data: MarketData):
        '''onReceived'''

    @abstractmethod
    def onOpen(self, data: MarketData):
        '''onOpen'''

    @abstractmethod
    def onDone(self, data: MarketData):
        '''onDone'''

    @abstractmethod
    def onChange(self, data: MarketData):
        '''onChange'''

    @abstractmethod
    def onError(self, data: MarketData):
        '''onError'''

    @abstractmethod
    def onAnalyze(self, data):
        '''onError'''


class NullCallback(Callback):
    def __init__(self):
        pass

    def onMatch(self, data: MarketData):
        pass

    def onReceived(self, data: MarketData):
        pass

    def onOpen(self, data: MarketData):
        pass

    def onDone(self, data: MarketData):
        pass

    def onChange(self, data: MarketData):
        pass

    def onError(self, data: MarketData):
        pass

    def onAnalyze(self, data):
        pass


class Print(Callback):
    def __init__(self,
                 onMatch=True,
                 onReceived=True,
                 onOpen=True,
                 onDone=True,
                 onChange=True,
                 onError=True):

        if not onMatch:
            setattr(self, 'onMatch', False)
        if not onReceived:
            setattr(self, 'onReceived', False)
        if not onOpen:
            setattr(self, 'onOpen', False)
        if not onDone:
            setattr(self, 'onDone', False)
        if not onChange:
            setattr(self, 'onChange', False)
        if not onError:
            setattr(self, 'onError', False)

    def onMatch(self, data: MarketData):
        print(data)

    def onReceived(self, data: MarketData):
        print(data)

    def onOpen(self, data: MarketData):
        print(data)

    def onDone(self, data: MarketData):
        print(data)

    def onChange(self, data: MarketData):
        print(data)

    def onError(self, data: MarketData):
        print(data)

    def onAnalyze(self, data):
        pass
