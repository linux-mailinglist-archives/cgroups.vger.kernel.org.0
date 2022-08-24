Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3736B59F8B5
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 13:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiHXLkc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 07:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbiHXLkb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 07:40:31 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3830B4F696
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 04:40:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 08F49580DD3;
        Wed, 24 Aug 2022 07:40:26 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 24 Aug 2022 07:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1661341226; x=
        1661344826; bh=e8VH2Kk8ncrPNHZi3c++JZcHD93/Vywl4g4DsjOv9gk=; b=B
        OvUm8PuRrxai3Q8wESMEtG3XtpaQvTpxSXS6vuknUciSZTFQvVSeg0sdbd0ZLPQ0
        G3nlZcu3dlULyBT8+0wbEXVfUNgDUD/QTTjvgdWVveA4My+y9B5TZcG7Vmy4zQAA
        Bh6h7YmwrV9F1c8qnT+FrwiGwkJzIEK+WPRC4WSsscMNWihQtrFI3QXhPWViedS6
        sGo8kQceWRVL6xDbhQOaLit4WVji75EKemTCw2py+dReqWLnVdFqWhlXAVUUj3jn
        zbp+7L/pZQf5lutOqeNMJlDlCValdarwJ/6jhNF+Z+U0v1qemNpSfcWwfW4CXJgu
        NRxkRSIHPXR/nAN8uRMJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661341226; x=1661344826; bh=e8VH2Kk8ncrPNHZi3c++JZcHD93/
        Vywl4g4DsjOv9gk=; b=w3CJ3B5+BX2Tw75VIvXL5uYZTeaeFOAj59hKF23FOfu8
        w7Yzu0u1iLF2HLeH0XAdB183OmfkHUsKBeMalaH9jrFjrJKy/+wBU/m7ITFq+GJA
        e6uljsENK0wnIe7JkqvCbC1zWSRp2dlI8G5OtBJt8FGUNUbszR4UMvFZZWir+Hfy
        WbWimr12cQ4pZsccjbT3lrudrH3YehieMRAc7Z8e0dbYjpDprkDXR20B8NXUZe1S
        9O+dAQ0DekoRBOdQD1WnHlaMOawdz4EIpXdeAxFIdLW66B1Pp2Cod8uzris654ph
        DdasJ24L5Tdt2ztS1LRigW3OR3yFn8hWBP037JyelQ==
X-ME-Sender: <xms:KQ4GYyFJndUieCD2u0phO7JhlfOiWk6KBlM6mwjay9jPTV-KctW5nQ>
    <xme:KQ4GYzXlDZTV3aNYFbdjIjC50U3rz7v1-1ePL6yHFzEYSWt-OcxHimbLVVkVF_Rdk
    Hc6pTiVVlhjPVhPwQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejuddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeefheeliedugeeuleetffeuheegkeetgfdtveevudff
    gfejvdegveeljefhvdefhfenucffohhmrghinhepghhoohhglhgvrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgho
    lhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:KQ4GY8KNFMAKQd8YIB0esK1-ARrxtimPoC9F3q3tf4GFG5DJjU9I1A>
    <xmx:KQ4GY8ET2G-RaZ0f95aGmYJYhW30te-WiutnjzMJ4kBU_t60zvQ96A>
    <xmx:KQ4GY4WT75AiGEHXEFOy9JMaZfJSKZV8dzlkva0XZzf8pmrLISf9SQ>
    <xmx:KQ4GYxfhCKrpaufb_gM3TjTi0Zvg1GhiolD8_cQVwiuup1DwyZvkkw>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 750661700082; Wed, 24 Aug 2022 07:40:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <f354bbb3-6619-4ab0-b0fb-a0098ffb0205@www.fastmail.com>
In-Reply-To: <YwU0mLBMuxpZ7Zwq@slm.duckdns.org>
References: <d0df567c-1f6a-418d-8db7-3f777bd109c8@www.fastmail.com>
 <YwUcGvE/rhHEZ+KO@slm.duckdns.org>
 <9412f39b-9ec1-4542-944c-19577a358b97@www.fastmail.com>
 <0a6105f9-012a-4b75-b741-6549d7e169d8@www.fastmail.com>
 <YwU0mLBMuxpZ7Zwq@slm.duckdns.org>
Date:   Wed, 24 Aug 2022 07:40:03 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Tejun Heo" <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, "Johannes Weiner" <hannes@cmpxchg.org>
Subject: Re: oomd with 6.0-rc1 has ridiculously high memory pressure stats wit
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On Tue, Aug 23, 2022, at 4:12 PM, Tejun Heo wrote:
> On Tue, Aug 23, 2022 at 02:59:29PM -0400, Chris Murphy wrote:
>> Same VM but a different boot:
>> 
>> Excerpts:
>> 
>> /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/gvfs-goa-volume-monitor.service/io.pressure:some avg10=3031575.41 avg60=56713935870.67 avg300=624837039080.83 total=18446621498826359
>> /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/gvfs-goa-volume-monitor.service/io.pressure:full avg10=3031575.41 avg60=56713935870.80 avg300=624837039080.99 total=16045481047390973
>> 
>> None of that seems possible.
>> 
>> io is also affected:
>> 
>> /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/org.gnome.SettingsDaemon.Smartcard.service/io.pressure:full avg10=0.00 avg60=0.13 avg300=626490311370.87 total=16045481047397307
>> 
>> # oomctl
>> # grep -R . /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/
>> https://drive.google.com/file/d/1JoUxjQ2ribDvn5jmydCWXJdg0daaNScG/view?usp=sharing
>> 
>> We're going to try reverting 5f69a6577bc33d8f6d6bbe02bccdeb357b287f56 and see if it helps.
>
> Can you see whether the following helps?
>
> Thanks.
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index ec66b40bdd40..00d62681ea6a 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -957,7 +957,7 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
>  	if (static_branch_likely(&psi_disabled))
>  		return 0;
> 
> -	cgroup->psi = kmalloc(sizeof(struct psi_group), GFP_KERNEL);
> +	cgroup->psi = kzalloc(sizeof(struct psi_group), GFP_KERNEL);
>  	if (!cgroup->psi)
>  		return -ENOMEM;

Looks like it's fixed in limited testing. It'll get put into Rawhide and automated testing today hopefully. Thanks!

-- 
Chris Murphy
