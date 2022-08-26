Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4FD5A2765
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 14:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiHZMGo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 08:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiHZMGn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 08:06:43 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2245B74346
        for <cgroups@vger.kernel.org>; Fri, 26 Aug 2022 05:06:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 261415803BE;
        Fri, 26 Aug 2022 08:06:37 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Fri, 26 Aug 2022 08:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1661515597; x=
        1661519197; bh=wb1n5fS7L6RXPJKttg8STGRunHj8c0XRsh6M4VcNCgM=; b=G
        APTEasDK+u5nysVOiR9MlQ8EQHl7WbSgWdTpqg80cu3ERl1Sr5ts++/uxGVuDnun
        xZhoTVvttSbIbLv57cx1h/EPeXBroKDJNoL/U2ELJ3OR8tU3AuBw83873MvHWoMO
        PSBhLgvH7ygYbb2t4zIv0+hCCNwRHPLsMzWacWt3HdKyEapY07djoJFBxof7AZEX
        8zSkVfEK44MiWISgNvjD9Vv/gs+n1HmE7L3gI4E2kfO52ZhqBZ6YVIEqhOSGiOfh
        YQtYSmk5W8lbCYrPeX+/2UZlnb5rOUgu3geoOy9TtaXat82rKUFeMDDJx5Z/P8ei
        h6uEGvy3vjm82C0DYktnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661515597; x=1661519197; bh=wb1n5fS7L6RXPJKttg8STGRunHj8
        c0XRsh6M4VcNCgM=; b=BkBPFOtWDKtu3IeKsN7SNq0onZJSg5jB73Wp+UJszxX6
        L0XldxixuvVAvyFI5slhRFc+/d83wAkUj+V3RL8qApaMnjARtAEwOUR6tlCqI4ql
        Pag0PNnkMGt908VbwmJmjPreO5+av+dhosYfoxg+G4FafzwSlHYI3MH0+uvx3m03
        2BdY2sGrInxTHjhYXJd96JGs5IXcLw1PNByhVQIC1mU3c+1xwuECilLtGOqeDjDR
        zdhgJHEAiOjWxF8iIfjry73lJq5buMB+axm48npyCackaj31uohH+h5E0qQbNpv4
        ep+7iut+a+oNvM5qDtllCaKB9gmDKMJjZouTiCiA3Q==
X-ME-Sender: <xms:TLcIY6hzuU7TMgLO9ZtlccLAvWwTI9yMk72uNUH_3uqigSfoEWr-bQ>
    <xme:TLcIY7BKtbl3tc-tIsqw977SpSw4ob6joEHajXcOO3-J524LqD6e_7HiTS63ox3yf
    t7pI6MoEmSz3bF7Teg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoegthhhrihhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeduleetffduheduheeihedtieehteehueffhfdvkefg
    hfeiueehffduheejleekgeenucffohhmrghinhepghhoohhglhgvrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrhhishestgho
    lhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:TLcIYyFF62RZ8W9hGI69o70l3QEu0b7V7GnaSbaG339e2r7PCGLVzQ>
    <xmx:TLcIYzSBl_Xc66FeWpqQ6HHmMtBbd_SbRkoN1ZA6Su8-6lmBPGUbsQ>
    <xmx:TLcIY3x_yh8yXo7sfCdflawjUDTDMfdq0biTIAsXHnnsXQk-mp1zlg>
    <xmx:TbcIYwr_odV0gzjK5tLXyF91HcpDzrCS8-2M6ofQSod6AhbhuMD33g>
Feedback-ID: i07814636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 93FF81700083; Fri, 26 Aug 2022 08:06:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <a7a96563-fd07-4970-8c25-f0784c83c915@www.fastmail.com>
In-Reply-To: <f354bbb3-6619-4ab0-b0fb-a0098ffb0205@www.fastmail.com>
References: <d0df567c-1f6a-418d-8db7-3f777bd109c8@www.fastmail.com>
 <YwUcGvE/rhHEZ+KO@slm.duckdns.org>
 <9412f39b-9ec1-4542-944c-19577a358b97@www.fastmail.com>
 <0a6105f9-012a-4b75-b741-6549d7e169d8@www.fastmail.com>
 <YwU0mLBMuxpZ7Zwq@slm.duckdns.org>
 <f354bbb3-6619-4ab0-b0fb-a0098ffb0205@www.fastmail.com>
Date:   Fri, 26 Aug 2022 08:06:15 -0400
From:   "Chris Murphy" <chris@colorremedies.com>
To:     "Chris Murphy" <lists@colorremedies.com>,
        "Tejun Heo" <tj@kernel.org>
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



On Wed, Aug 24, 2022, at 7:40 AM, Chris Murphy wrote:
> On Tue, Aug 23, 2022, at 4:12 PM, Tejun Heo wrote:
>> On Tue, Aug 23, 2022 at 02:59:29PM -0400, Chris Murphy wrote:
>>> Same VM but a different boot:
>>> 
>>> Excerpts:
>>> 
>>> /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/gvfs-goa-volume-monitor.service/io.pressure:some avg10=3031575.41 avg60=56713935870.67 avg300=624837039080.83 total=18446621498826359
>>> /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/gvfs-goa-volume-monitor.service/io.pressure:full avg10=3031575.41 avg60=56713935870.80 avg300=624837039080.99 total=16045481047390973
>>> 
>>> None of that seems possible.
>>> 
>>> io is also affected:
>>> 
>>> /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/org.gnome.SettingsDaemon.Smartcard.service/io.pressure:full avg10=0.00 avg60=0.13 avg300=626490311370.87 total=16045481047397307
>>> 
>>> # oomctl
>>> # grep -R . /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/
>>> https://drive.google.com/file/d/1JoUxjQ2ribDvn5jmydCWXJdg0daaNScG/view?usp=sharing
>>> 
>>> We're going to try reverting 5f69a6577bc33d8f6d6bbe02bccdeb357b287f56 and see if it helps.
>>
>> Can you see whether the following helps?
>>
>> Thanks.
>>
>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> index ec66b40bdd40..00d62681ea6a 100644
>> --- a/kernel/sched/psi.c
>> +++ b/kernel/sched/psi.c
>> @@ -957,7 +957,7 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
>>  	if (static_branch_likely(&psi_disabled))
>>  		return 0;
>> 
>> -	cgroup->psi = kmalloc(sizeof(struct psi_group), GFP_KERNEL);
>> +	cgroup->psi = kzalloc(sizeof(struct psi_group), GFP_KERNEL);
>>  	if (!cgroup->psi)
>>  		return -ENOMEM;
>
> Looks like it's fixed in limited testing. It'll get put into Rawhide 
> and automated testing today hopefully. 

Patch has been in Rawhide without any failures, consider it fixed. Thanks!


-- 
Chris Murphy
