Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F1959AACF
	for <lists+cgroups@lfdr.de>; Sat, 20 Aug 2022 05:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiHTDAw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Aug 2022 23:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiHTDAu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Aug 2022 23:00:50 -0400
X-Greylist: delayed 536 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Aug 2022 20:00:49 PDT
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0199ECD534
        for <cgroups@vger.kernel.org>; Fri, 19 Aug 2022 20:00:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id DF7FD580729
        for <cgroups@vger.kernel.org>; Fri, 19 Aug 2022 22:51:48 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Fri, 19 Aug 2022 22:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1660963908; x=1660967508; bh=CySVD2aXxm
        hI+TuehF6fV37tTPOWww490mlaiYMjGoQ=; b=MrQ4H/yqRLgd4uB4MJG3Bm2A/v
        80UcBetvHM95cQC0BWqLIaSFaUaUy68q0hpHlO/dyXYUI0lhJAXgneJGibYnFFa+
        oKQ5GS693Ksr9CeFLI4Xi4DW3a+CAcnc1ddRTQGMB9yFurUluAm47UjfcIeaHUD1
        HElFhvxoBHMtpaU8dflueA1DhSjUPlYIm9hQqHOfZQH8XPoJO8wxmJkKgGt8vTfz
        yIcWAmOEQmywwl05GFizYBuhmJ0SFa8SKIBbJ7lCc7y6ItLHaNohe1VxMjiIoj6M
        MqdF0cJqyp8BQAPcLLwrRFhjkH5923I8dnWGlofUV/ybyUs7OOn3ydr3jUGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660963908; x=
        1660967508; bh=CySVD2aXxmhI+TuehF6fV37tTPOWww490mlaiYMjGoQ=; b=0
        SiUMNo4dXrPnteHYqVhOgZeN9vtAJ56CaIxKFW0YRxFDg0FsqkkCSb5VP8YNE2q6
        EQllrv5cC3zoNkS6kKW3hBUFVmQVxA6eKkhOmGE3URI3gToBNxpHhWS5xp+NN9on
        Yr1WkRfubBaSGU/C2qEhXnXjg5NLk6qTzLp+orDtuMMwVMj4kUaQF1YEuId+ZPgv
        vAyhmnpm8MT56er9sDfhPWbC2a6OOYwvxzZ/vX+5BRctswKTgyFyRushEq9Tf5vV
        TPWu+fwGCChbR4IK4RNGVYWLpVSH33JPussbXekbigpafVI3vVF5ay866juyWe2w
        Ri6Z5jrV8LmVLdMaNtU4Q==
X-ME-Sender: <xms:REwAY-fNpbOxl2CteMru8nv7G7xXOWn8vjysmMESNSqLL1sRLdzoLw>
    <xme:REwAY4NRgN-uEAUxWgjzUg05ooigpRGgZR3IIP7vvuPSj6otrfa36GGWCfrLBMNAo
    8Z-S3B3MQhTyQVEzbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeivddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhl
    ohhrrhgvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeeffeeltdejheefud
    etjedvleffvdevieegueegffdvffevffevkeeivdfhkeeikeenucffohhmrghinheprhgv
    ughhrghtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:REwAY_i-Ail5FkOwnIR5jvuYFx7rRBaQ9zBTsVTTN0m5gTbUZBUyxg>
    <xmx:REwAY7-LQU-u6_t-xQeGX07mc3F9ao9Jz20ZR2J3ShdXGDvujPN2Tw>
    <xmx:REwAY6vezVTHsPyj_kSFrSRac60wTlWm4Z5Ijcwu_kXz1fRU2oOKsQ>
    <xmx:REwAY45u9eo9Nl3hGvUXA-r9TKLeDoavnyjn5MjfqaFtSvOQj8AsqQ>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5CB4F1700404; Fri, 19 Aug 2022 22:51:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <d0df567c-1f6a-418d-8db7-3f777bd109c8@www.fastmail.com>
Date:   Fri, 19 Aug 2022 22:51:27 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     cgroups@vger.kernel.org
Subject: oomd with 6.0-rc1 has ridiculously high memory pressure stats wit
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

Tracking a downstream bug in Fedora Rawhide testing, where 6.0-rc1 has landed, and we're seeing various GNOME components getting kllled off by systemd-oomd, with the stats showing suspiciously high values:

https://bugzilla.redhat.com/show_bug.cgi?id=2119518

e.g.

Killed /user.slice/user-1000.slice/user@1000.service/session.slice/org.gnome.Shell@wayland.service due to memory pressure for /user.slice/user-1000.slice/user@1000.service being 27925460729.27% > 50.00% for > 20s with reclaim activity

I'm not seeing evidence of high memory pressure in /proc/pressure though, whereas oomd is reporting really high memory pressure and absolute time for it that makes no sense at all:

>>Sep 09 03:01:05 fedora systemd-oomd[604]:                 Pressure: Avg10: 1255260529528.42 Avg60: 325612.68 Avg300: 757127258245.62 Total: 2month 4w 2d 8h 15min 12s

It's been up for about 2 minutes at this point, not 3 months.

Thanks,


--
Chris Murphy Murphy
