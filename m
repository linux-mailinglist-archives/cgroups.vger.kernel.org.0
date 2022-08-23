Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26F859ECBC
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiHWTr4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 15:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiHWTq6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 15:46:58 -0400
X-Greylist: delayed 597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Aug 2022 11:50:51 PDT
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C046F58DF8
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 11:50:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 59E642B05FAD;
        Tue, 23 Aug 2022 14:40:52 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 23 Aug 2022 14:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1661280051; x=
        1661283651; bh=qvny2MgkE8/C3PWUD0tDtZJxNolLM559Kqa+QIqtMUA=; b=K
        7w6Xowcj/wsqu3/e8ZORXa7EepCuFIrI8RdqNPyhFAeFj2KPChPOHkSv+nQEbjZS
        kWlmyF6JVr8dLUD9EuNBTJ6yuC2tRZjPWO/dGJnDE33cx6LUCchdzpIt/T8sUdUh
        0czgjEHEaGBB50ylU1/Hg7ZQs7S3LKEXTILGoSUBA7pND+Ve/XOR4xZ1pjieRizs
        a1PLAnVq3DFuTqayxSBLcjSesDccXfoqJ5HkhvxMeVy04rzdN2tWXkMc6iP2eHJx
        Yg9VXGxmci2zSaxF1+b3RUiWLLRRi6L9+gZJC9C8i7fuSpsaCZ7sr4Ifch8/Qyy9
        Oks++rIrYzJwtMANGK+RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661280051; x=1661283651; bh=qvny2MgkE8/C3PWUD0tDtZJxNolL
        M559Kqa+QIqtMUA=; b=TLEmUb3YwzgEamXl3Z8ym66biGkJJLOkC466v7hdLvzm
        /fQ1q6rlVmBmVIFhmbt13bOLk3Z4bWnub8SRrWEaAWTvlUVeMFCuISVCMmEqIfOT
        7Ixbb43rRBiarFhkPYQCVewFp4b8Z8OkBxBjKl9/Irs5O8fqRJ+R6c629j8ufxVc
        bxArl9pGQN3T31choEzxZKg80aTNOYu+FHb0RlgzGleu8QrQLPSihxEQN+gue8Vj
        xpmn/qdG0OTgfMb20M3NnUYi/uTH8omNewZuzuW4+5/x2jgZzthxrObldPqRxGDK
        w7QbO6vOfpwqmD+KlMwjZfmbLopIDJnbifZRgJiD1g==
X-ME-Sender: <xms:Mx8FYzEwz7SE6veUosIL1vZhn_ilhoBdofr3KYFYaezLpI325aAatQ>
    <xme:Mx8FYwWnpVQRQDJ5eAZs2KisOWY4Uxd0XSPfoqDAAi75Qz7HE8M-y0q2B8aJGYtO0
    J4ainLBqiANKJXv5QU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeiledguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepfeehleeiudegueelteffueehgeektefgtdevvedu
    fffgjedvgeevleejhfdvfefhnecuffhomhgrihhnpehgohhoghhlvgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegt
    ohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:Mx8FY1LzkiRbEYRUAzEdiNcKn2FMF3FyjSBz7tKHKZLGz9MNtpHdrA>
    <xmx:Mx8FYxGyqEnYWah1UU5oDN718CFlU3AxTJ5Fev81BWDRc0iGHte47A>
    <xmx:Mx8FY5Xbvg60DkC1LLUfbSQnsYx_De83O9xIMevPyCYkjri5KI-twQ>
    <xmx:Mx8FY6doOD1kMc0vf8U3ddJzC_mmxdCexkw4vjK4PJKu2TIkWq_XaHxe3ro>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 398F81700082; Tue, 23 Aug 2022 14:40:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <9412f39b-9ec1-4542-944c-19577a358b97@www.fastmail.com>
In-Reply-To: <YwUcGvE/rhHEZ+KO@slm.duckdns.org>
References: <d0df567c-1f6a-418d-8db7-3f777bd109c8@www.fastmail.com>
 <YwUcGvE/rhHEZ+KO@slm.duckdns.org>
Date:   Tue, 23 Aug 2022 14:39:37 -0400
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

Another example,  with 6.0-rc2:

# oomctl
Dry Run: no
Swap Used Limit: 90.00%
Default Memory Pressure Limit: 60.00%
Default Memory Pressure Duration: 20s
System Context:
        Memory: Used: 1.7G Total: 3.8G
        Swap: Used: 0B Total: 3.8G
Swap Monitored CGroups:
        Path: /
                Swap Usage: (see System Context)
Memory Pressure Monitored CGroups:
        Path: /user.slice/user-1000.slice/user@1000.service
                Memory Pressure Limit: 50.00%
                Pressure: Avg10: 0.00 Avg60: 0.00 Avg300: 0.10 Total: 140y 3month 18h 24min 20s
                Current Memory Usage: 1.5G
                Memory Min: 250.0M
                Memory Low: 0B
                Pgscan: 0
                Last Pgscan: 0
# cat /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/memory.pressure
some avg10=0.00 avg60=0.00 avg300=0.18 total=8367757640799118
full avg10=0.00 avg60=0.00 avg300=0.07 total=4426019660641432

# grep -R . /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/
https://drive.google.com/file/d/1Ro6rKnEx1CCapmO3rz6SDysjP1Bs4_Re/view?usp=sharing 

Actual uptime is ~10 minutes.

-- 
Chris Murphy
