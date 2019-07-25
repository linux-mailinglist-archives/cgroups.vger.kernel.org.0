Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB24A7504D
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2019 15:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfGYN4U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Jul 2019 09:56:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52820 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfGYN4U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Jul 2019 09:56:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so45087451wms.2;
        Thu, 25 Jul 2019 06:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ijKb9xkNQpLXP3ePyMDNd5C2fEcHsiRFSZbSc5IKwxM=;
        b=TsCFOLazPPC9sGh202Kobh/yPQrBmnaqShEAsYKLqQO3VNfmeJJYk/TywMrrUGJ0NL
         +YJy1nGykJKnieNuddH32ahJFUEhWfLPbcxWIj71+1L1N/b9DHGkLQTdDheQJUdmhhfh
         /qfiS0UapR+mySo3aXeazFrZjACw20RBjdfWEsvGKEgLv6MZBAfwFN+my8tD46Y4i4E1
         NS4U2Q4xG6REuvi31RMpEpeH5tMyKBWU76pjsxHozO6iLXS7pcrms3mnb49CfN8ApVtM
         5nNF3gcqjM3ArdyE1bjXeiFo2dNYTfKkO9qfZ/eQ0FPq3CVPXR+9rhMQ1+ZeX35QCSFp
         ZA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ijKb9xkNQpLXP3ePyMDNd5C2fEcHsiRFSZbSc5IKwxM=;
        b=JuQQxBQBlHq04YhizdYD7+WXkU1kXlnfIRUBEqTzVkBHg3e7KiArfG1F6zZqACCKoM
         rK46yOGrV99GDNhxC+5SEFgFs0fNseCErITzOxfFvVQAda9omzolNjUDoPy9kErJGgLI
         ZbFN2pi02v+8+IwMGkkkUg1fp2zfgsHpLIEbOIs4s+SXfDzMiRX0Qw/9sm24uJipYkhe
         JzwdJ1TPZtX1RfCkh8xAsqQ+0LiBAuPI3o3DNwJ6Q3OuTT50Lo9nImON8tr8Ojf602cn
         8pMwGvkI9NbX+EYGKctl8+3GBvMLP6UPfSaZHIwfthn0bdb9+K167TFDzHrEoXulizZD
         bNxQ==
X-Gm-Message-State: APjAAAUqN/MtUcYAp/EzyNI6n2P1j4dMCpzR7caO3ecSspiQwgQTzwn6
        F09JQeKUoJXkdeDEiaBtPKQ=
X-Google-Smtp-Source: APXvYqwV57hxYZ2iz1hb3kPahcmQuB05GV8QWb5v2lzdhH3COHujj5QS8w5a/awpNNDpJ2LiGvIfCA==
X-Received: by 2002:a1c:5453:: with SMTP id p19mr74461459wmi.148.1564062978247;
        Thu, 25 Jul 2019 06:56:18 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u186sm84400263wmu.26.2019.07.25.06.56.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 06:56:17 -0700 (PDT)
Date:   Thu, 25 Jul 2019 15:56:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        dietmar.eggemann@arm.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20190725135615.GB108579@gmail.com>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-4-juri.lelli@redhat.com>
 <20190725135351.GA108579@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725135351.GA108579@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > When the topology of root domains is modified by CPUset or CPUhotplug
> > operations information about the current deadline bandwidth held in the
> > root domain is lost.
> > 
> > This patch addresses the issue by recalculating the lost deadline
> > bandwidth information by circling through the deadline tasks held in
> > CPUsets and adding their current load to the root domain they are
> > associated with.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> 
> Was this commit written by Mathieu? If yes then it's missing a From line. 
> If not then the Signed-off-by should probably be changed to Acked-by or 
> Reviewed-by?

So for now I'm assuming that the original patch was written by Mathieu, 
with modifications by you. So I added his From line and extended the SOB 
chain with the additional information that you modified the patch:

    Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
    Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
    Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
    [ Various additional modifications. ]
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

Let me know if that's not accurate!

Thanks,

	Ingo
