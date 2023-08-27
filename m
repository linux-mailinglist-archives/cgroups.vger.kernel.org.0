Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4C6789C28
	for <lists+cgroups@lfdr.de>; Sun, 27 Aug 2023 10:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjH0IfZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 27 Aug 2023 04:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjH0IfQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 27 Aug 2023 04:35:16 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A2E13E;
        Sun, 27 Aug 2023 01:35:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B4C383200319;
        Sun, 27 Aug 2023 04:35:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 27 Aug 2023 04:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1693125307; x=1693211707; bh=Jv
        SLkiKnJg7r+Lmp4xfUHOcdesoZivHQDSlyjxiRtjQ=; b=vPqEkglFojsGGcLwBY
        lG2flpx9r8FmK5nCGywrpMX6PsceUo6YMrQv5fmBo9/gO8FzmGv9znw1P2Yt0jtD
        c5+R/u/yoDrT9KSfvQWhalUtinE+HIV+zSpAYoxAWisbOyuRKEaMvY5E/o8UCSrm
        RpRm3pQFxDacMfyK1PcCI+WbXz2DDzzgjLBo1/n150V3elpBEgllIEN9oI/3EzR0
        Mp3uqCE3pnzLz/XTtdfVsInoFuXIAmSivUvDTfEi+tXp+pYef+22ZzUrWRtWOGr5
        GaeliZwdz5J+FHRGsCwsO+ZxBT0DOYMBs2nvCz0nIFZ4EnvdXkHmfHldgnQY57H4
        msrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693125307; x=1693211707; bh=JvSLkiKnJg7r+
        Lmp4xfUHOcdesoZivHQDSlyjxiRtjQ=; b=dw9ckfY77+MEfwvYwJUcSP4uls71J
        VtLEfkwJ8fKC9fY1xQcdppEfrpZUkwBOjqQyjDnagJ3PPReh25wkDsSLS+9ovDO8
        N9p874zu3l+uWZfRhpeJsqtlz0X/I4E+7hipxtG8glESaI+Tcf0jflqr9LvEFyTQ
        oOG+jwwFx/AfvdhhVcdkcXPfQlsSsCPJrxjdNU2+8waAwtDrUws71DkJI+V6rvA6
        7AgCy8tWblmYdWoAYfXeMd9HISZMGaGP/AHF6byvYwlbetg6aLgagHXO1e7gcJHQ
        CyINkG9SDT8HJjBWhRsckcuzKfuWQANtihzvUr2UVAUYXmEwY+EONbw6w==
X-ME-Sender: <xms:uQrrZOS-kh0pyOe49ny85SsfJ24F51Y2xJFkp2QUhjpJ-ScJmL29LQ>
    <xme:uQrrZDw7Imluec5MYyJM4Ck-ryAZyYgxr14T_GLrXA0_5fvzM6VVTCQf_Ei23gpTX
    dnxaCxahgWz5g>
X-ME-Received: <xmr:uQrrZL14ex-M6nzQlLzFQ2RgwRmAWIag21IAuU8LUVZWSl7LAOWPIc1z5fPxUQnH2D93n6gpywAlwp3BTtJne6ky2DKRN8lxyXQZUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefvddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:uQrrZKCiK88Rv7-CJwZcB91EGASYBfs9G7kv2ibidQZu-ZdAKZPbiQ>
    <xmx:uQrrZHjCc1Gmb7ondYPb5CyCwN9tXzklK7xM1ivcrW_JZXnguoElrg>
    <xmx:uQrrZGo5iIZ847KDiZ-nnrTx90AagiXELL4iXqJdYgAPQIgnYXdJug>
    <xmx:uwrrZGR9hrNTOC1O2i45rppOsf2jHUzYBwAghWFfcDNGUvcYqhQNwQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Aug 2023 04:35:05 -0400 (EDT)
Date:   Sun, 27 Aug 2023 10:34:53 +0200
From:   Greg KH <greg@kroah.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     stable@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Backport rework of deadline bandwidth restoration
 for 6.4.y
Message-ID: <2023082742-dad-henna-cb35@gregkh>
References: <20230821221956.698117-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821221956.698117-1-qyousef@layalina.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 21, 2023 at 11:19:50PM +0100, Qais Yousef wrote:
> This is a backport of the series that fixes the way deadline bandwidth
> restoration is done which is causing noticeable delay on resume path. It also
> converts the cpuset lock back into a mutex which some users on Android too.
> I lack the details but AFAIU the read/write semaphore was slower on high
> contention.
> 
> Compile tested against some randconfig for different archs. Only boot tested on
> x86 qemu.
> 
> Based on v6.4.11
> 
> Original series:
> 
> 	https://lore.kernel.org/lkml/20230508075854.17215-1-juri.lelli@redhat.com/
> 
> Thanks!

All backports now queued up, thanks for doing this work!

greg k-h
