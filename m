Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD00559ECE9
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 21:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiHWTyC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 15:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiHWTxn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 15:53:43 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2660585AA9
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 12:00:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 4853A2B06039;
        Tue, 23 Aug 2022 15:00:00 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 23 Aug 2022 15:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1661281199; x=
        1661284799; bh=GABU8m9X+3Sbt6EutiL3q4wNZa+NudfPpXTG5PFEDEc=; b=J
        VxHbywQ9/0IUpy/f8GElZtPuzY9EYW15iOTJfUdQWjX5cVXQvukm+on0M6GHaTB5
        dEtTbUtHg3NQlJffPC4At51olMDDZPSRMy/iJVJPGyxd9QonI1ca89oSFLa3UP7v
        nQWAy6puroP6HRzmzoy5V7ocWVlvV4vNKDyWAbAgE0jB2ZsZ+Q9Ue4a4Ma37XMZc
        DCumZrd9sYwbJNttHCUJIgww6N1DHJEsSR2qlB8lpVqQocay/3aPSxlv2R0Se0cB
        RVj6PYiGuF4rv/Uhmh2zDNH4saxT7Z+y6u6+I+srEy+2BPk4el1DtFMjjmgfEttC
        Qm2pobhaYl1tvjvvOqeiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661281199; x=1661284799; bh=GABU8m9X+3Sbt6EutiL3q4wNZa+N
        udfPpXTG5PFEDEc=; b=HAHCAfOxbY2zG0WsV+9hm5E7/FudcY2xPH/uSXt1lwNZ
        Sja+MyN0CPATm0q/YPvWkRaqiCKYXeJVgbRDX281R4FvdWGDwADhgSfjVNwwWviZ
        W+DS7lRA6f5JlM4rQtIH90U4YMSyLm0NECNFqUfP4ivYUUh74Ymy8jn2NluQ4zSd
        Vgu+Xz89XhNEwgCEB2mGKoGGt/8eyDBFPE1LKpyPmANEr0SpdIKIX46+al1XilSJ
        zuc9RtYZ5eBo+N/0OSNXBW+M4zWSW6siSihocAP32yGEG5vPMs1P7LYtdk5Rdr4I
        1+aghiS/Jqo05cfTtaUZu9PnwpMTnippAs7CE/d6Og==
X-ME-Sender: <xms:ryMFY0pdseY4f5_bbpGhVk6ddE80W87Rq0nElc28taMMTZ3jY74NMQ>
    <xme:ryMFY6pQgwekFWEgB_MjcUrItB_8N1I5DKqWYHGPSRbiVIDba8TDMpjjWov-Gn2-4
    96seKJzJvLVDJiosZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeiledgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepfeehleeiudegueelteffueehgeektefgtdevvedu
    fffgjedvgeevleejhfdvfefhnecuffhomhgrihhnpehgohhoghhlvgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegt
    ohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:ryMFY5Nseu0eZ_-8tQvZ9CQtz3j93pqiC3VWBOe59I7iO3EUt4IKHA>
    <xmx:ryMFY764E_H658N3GgeIZXWvegx5_OyQZNL_cud5lcTi8kgX2nbbyQ>
    <xmx:ryMFYz4hzKynoItm3va8VJy22xEeEJAQRTA_cSao0en-ftlA2o_ENA>
    <xmx:ryMFYwhpw8zll9viEvPnS_fw2tab321_v6NxHrt0hp_WvPjrhxAsdvxEP1E>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 427BE1700082; Tue, 23 Aug 2022 14:59:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <0a6105f9-012a-4b75-b741-6549d7e169d8@www.fastmail.com>
In-Reply-To: <9412f39b-9ec1-4542-944c-19577a358b97@www.fastmail.com>
References: <d0df567c-1f6a-418d-8db7-3f777bd109c8@www.fastmail.com>
 <YwUcGvE/rhHEZ+KO@slm.duckdns.org>
 <9412f39b-9ec1-4542-944c-19577a358b97@www.fastmail.com>
Date:   Tue, 23 Aug 2022 14:59:29 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Tejun Heo" <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, "Johannes Weiner" <hannes@cmpxchg.org>
Subject: Re: oomd with 6.0-rc1 has ridiculously high memory pressure stats wit
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Same VM but a different boot:

Excerpts:

/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/gvfs-goa-volume-monitor.service/io.pressure:some avg10=3031575.41 avg60=56713935870.67 avg300=624837039080.83 total=18446621498826359
/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/gvfs-goa-volume-monitor.service/io.pressure:full avg10=3031575.41 avg60=56713935870.80 avg300=624837039080.99 total=16045481047390973

None of that seems possible.

io is also affected:

/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/org.gnome.SettingsDaemon.Smartcard.service/io.pressure:full avg10=0.00 avg60=0.13 avg300=626490311370.87 total=16045481047397307

# oomctl
# grep -R . /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/
https://drive.google.com/file/d/1JoUxjQ2ribDvn5jmydCWXJdg0daaNScG/view?usp=sharing

We're going to try reverting 5f69a6577bc33d8f6d6bbe02bccdeb357b287f56 and see if it helps.

--
Chris Murphy
