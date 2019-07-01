Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F95BEAD
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2019 16:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfGAOvM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Jul 2019 10:51:12 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:45798 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbfGAOvM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Jul 2019 10:51:12 -0400
Received: by mail-qk1-f177.google.com with SMTP id s22so11183650qkj.12;
        Mon, 01 Jul 2019 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LFTfYGGYUeKgWu6NCW1YsTlwMbMp4Vwr1bzk+8Gz8Ak=;
        b=u6eQoeM91T1GCI/UJBC0PTS8/th7cOVcP1Y3qqK4wm082WjdLTINYfDSegCbbH0iIy
         xftsOaBnEV/aLRYWIfEqSg4YdcL7/7rfktZrTIs5YXvDgabZBDNDPubzgeYFgtJcLDwn
         WgoWPHd8GGaAJGSEPpu6sWSGMyKGwC5g+cFYCq9TJbP2WPgmMhJ/ypP8YlSH+/GDyDUu
         2UxATb5TSXhScqj/mBFaTvE1GAZy6JH5Y4hI27fpNNovd5WVC3uuTSVYM2nNQaOXyOIa
         tqjM/RzhIWFpZiJ90d7AMd9dOPlj1jY4uQ24Y6pyBFspwIv8CiR4NoEGZmWRsS9QMi58
         1TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LFTfYGGYUeKgWu6NCW1YsTlwMbMp4Vwr1bzk+8Gz8Ak=;
        b=lD8CD0DZP7bHTpnz1cfoR26ZRqCmpLkGp2LubtwoeT/mKK7JxWEsSEWz0VXztor2ck
         da1Z2yqkGGtKZT9ZvwddKMy59mjkBwTgYsEC/chnwWadEb3jjHGLCd7dITSQaeVISWAl
         +fyUM+teUCOJjYBoioN/LXeRutAP956/0r3OZgUwBvoq36wZlwESACpSth1KpQ58eu3r
         /CuavfZ+20gHh0grt09JHrqRve6RuW2GrNZic1oAY5oQdu8iUqpJ/gnlsfQjKwqM2Uw1
         MOwjmYVUac38YlYxJSmvD+imtafnpxDiyC5fvNra1JfZFHGjjam+yae0XwduRoufH2WF
         ljUQ==
X-Gm-Message-State: APjAAAX2Hkn0rOw1Vq7S1eBYwTOCn6hQhpGjZxTQdR77gMSOgDzi8FeJ
        IteayFBv6Zm9A6vfxNueQZM=
X-Google-Smtp-Source: APXvYqxiARzDl515VDQpozB7dxcn184vwFbQIqkBHw7sJi9bGEJfhYy0qSUnAA+cYMGrJ6opL1juCw==
X-Received: by 2002:a37:668c:: with SMTP id a134mr21447324qkc.477.1561992671422;
        Mon, 01 Jul 2019 07:51:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d383])
        by smtp.gmail.com with ESMTPSA id h40sm5683084qth.4.2019.07.01.07.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 07:51:10 -0700 (PDT)
Date:   Mon, 1 Jul 2019 07:51:07 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Prateek Sood <prsood@codeaurora.org>
Subject: Re: [PATCH v8 6/8] cgroup/cpuset: Change cpuset_rwsem and hotplug
 lock order
Message-ID: <20190701145107.GY657710@devbig004.ftw2.facebook.com>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-7-juri.lelli@redhat.com>
 <20190628130308.GU3419@hirez.programming.kicks-ass.net>
 <20190701065233.GA26005@localhost.localdomain>
 <20190701082731.GP3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701082731.GP3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Jul 01, 2019 at 10:27:31AM +0200, Peter Zijlstra wrote:
> IIRC TJ figured it wasn't strictly required to fix the lock invertion at
> that time and they sorted it differently. If I (re)read the thread
> correctly the other day, he didn't have fundamental objections against
> it, but wanted the simpler fix.

Yeah I've got no objections to the change itself, it just wasn't
needed at the time.  We've had multiple issues there tho, so please
keep an eye open after the changes get merged.

Thanks.

-- 
tejun
