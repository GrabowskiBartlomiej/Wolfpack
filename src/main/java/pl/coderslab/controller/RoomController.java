package pl.coderslab.controller;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.coderslab.dao.ChannelDao;
import pl.coderslab.dao.RoomDao;
import pl.coderslab.dao.UserDao;
import pl.coderslab.entity.Channel;
import pl.coderslab.entity.Room;

import java.util.ArrayList;
import java.util.List;

@Controller

public class RoomController {
    private final RoomDao roomDao;
    private final ChannelDao channelDao;

    public RoomController(RoomDao roomDao,ChannelDao channelDao) {
        this.roomDao = roomDao;
        this.channelDao = channelDao;
    }

    @RequestMapping("/addRoom")
    public String addRoom(){
        Room room = new Room();
        room.setName("Random serw");
        List<Channel> channels = new ArrayList<>();
        channels.add(channelDao.findById(3));
        channels.add(channelDao.findById(4));
        room.setChannels(channels);
        roomDao.addRoom(room);
        return "/";
    }
}