Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755143BA5F6
	for <lists+cgroups@lfdr.de>; Sat,  3 Jul 2021 00:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhGBW3N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jul 2021 18:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhGBW3N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Jul 2021 18:29:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CE8C061762;
        Fri,  2 Jul 2021 15:26:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m15so1793903plx.7;
        Fri, 02 Jul 2021 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s1+mLyUtQCUAV2WWOyntQZbuF/k3KJ0qXJL3GSGY5Z0=;
        b=pkTu+y8uzUfmpZpZxCfdGhCWkpcTGT3XhbgnYRrJFo3EgmPEcB3ALvb6y+gtv5+gSL
         La6StCuj7lYmwwBsJcW7PrHmxk4aQkkXzF4cwVMXc2Kh7TlMTfgJYznDFlOjCJMPiLap
         ZCSGypci0hedQ3zs4jdoBdL8rppevZvttyoTAkUowR6LjAIz5mkPRy3xhGdFIIFTZO+2
         IoqT81yCdISrkdFmvAyWIwzlpIm6sKutr2CIikiJwr8ubW8IH+P1KdTXsxTaCILBrJye
         LdzmVgd4oilzQ2OzNrAtOJRderLjqc1N8bgJJX9J0I74PTaYjpUT/X97KBU6QqfLH31E
         w35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=s1+mLyUtQCUAV2WWOyntQZbuF/k3KJ0qXJL3GSGY5Z0=;
        b=e1qHfQbs5c2vQS4/qPBDgHK05NQR492uTo7KJn6XpKkIUV6Aucu7BxZtcTlRCh/dtM
         H1Hs920ZwGhrtu1611Uqb9Ufg3Ku9K5uK/6gMEiQei9UoO5512rbfK05dyBuc+jbDNwL
         UfR6DazC2Ze8JXRiFxXpCa8ppxvSud8gWoc5vDpUMkERo1trpkKgtehpmSAL7JR+NF/3
         dmpcXQoJ9GKyOx9Dxa0lH7dEU94yeKxyYoLQbkbzPmWyvHcs5ER7UgLKwL+KyAGPHy4a
         N9TAM9EJJtnhM/3hw/sLLFzDU++y9SJB9qXhjTUUN/NYxeeF09dhiDy3MbYuXTyFs0RS
         XAJQ==
X-Gm-Message-State: AOAM531J0u2zNVg+g/BFFcw2Whq2aMdmeBXFKdelKZlgyVRmOnCWu2k5
        XI4Is6l2na+UjQPU7Hi3Hdw=
X-Google-Smtp-Source: ABdhPJxpv/FlVhKOSAwoHiAPmBu1JmpiuWOfMIOGM8rT/ator53Y9fq3Ud8FEsWFbOENR1TqdChVxg==
X-Received: by 2002:a17:902:968a:b029:11d:6448:1352 with SMTP id n10-20020a170902968ab029011d64481352mr1594499plp.59.1625264800082;
        Fri, 02 Jul 2021 15:26:40 -0700 (PDT)
Received: from localhost (udp264798uds.hawaiiantel.net. [72.253.242.87])
        by smtp.gmail.com with ESMTPSA id j10sm3611835pjb.36.2021.07.02.15.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:26:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 2 Jul 2021 12:26:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Question] Do we need remote charging for cpu and cpuacct subsys?
Message-ID: <YN+Sne76dhKBzV/R@mtj.duckdns.org>
References: <60decdb6.1c69fb81.6130e.7642@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60decdb6.1c69fb81.6130e.7642@mx.google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Jul 02, 2021 at 08:26:27AM -0000, Hao Lee wrote:
> memcg currently has a remote charging mechanism that can charge usage to other
> memcg instead of the one the task belongs to.
> 
> In our environment, we need to account the cpu usage consumed by some kworkers
> to a specific cgroup. Thus, we want to introduce a remote-charging mechanism to
> cpu and cpuacct subsys in our kernel.
> 
> I want to know if the community has a plan to do this?
> What will the community approach look like?

Yeah, we need sth like this to account for cpu cycles spent in commont path
but caused by specific cgroups - e.g. memory reclaim, net packet rx and so
on. There were some mentions of needing somthing like that but haven't been
any patchsets or concrete efforts that I know of.

Thanks.

-- 
tejun
