Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0B8510284C
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2019 16:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfKSPmV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Nov 2019 10:42:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46949 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfKSPmU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Nov 2019 10:42:20 -0500
Received: by mail-qk1-f194.google.com with SMTP id h15so18151827qka.13
        for <cgroups@vger.kernel.org>; Tue, 19 Nov 2019 07:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nWs/1bjDvNuzUJtmMQammwiguABeAIM4rx8Ev82Odj4=;
        b=us8sMchDRqbzZLY+8PM7/pe8WsLDZaohdyGl7R3EeSoWSvgvizJcLMF0BSaCEqsdy4
         NSYDM17Ete2jESTbIDna9vtA0dUXsmg6bBXQOCH48RDKNzLBxQ6mlp7dlkil/PAQ5hl4
         kxrZ3bqxv5B9F8bKvIHUq5QUdUopVtt0xgGF3OfR4oa410peA1MSURbcEDbJvRagtXXW
         +SqQC2r8fKOXJEA7CxMEGgKlIO7ejUpU40J+VxnUNJ6vEHK8//vMrnAp2qoHjQxavaiI
         vz7OWx7ODCOY89S+kEdO/+LJrWWnNLTcSyv0Maq4YAOgtfhCfquKCCUXG3oySb+mCvBb
         38tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nWs/1bjDvNuzUJtmMQammwiguABeAIM4rx8Ev82Odj4=;
        b=DnJiKjbi0B8g03GvzoYkg7CpHOLxXMsay97luMkvTWqGsuFiAeYGXxbr7ALeO7rvVP
         xjCDFzPG6PGJxSYF3FRCADtyid3HcRKNoyZbihZWXxDTN6M8u23hirt6YsABBDsmaHRl
         ocwjITZ6tjldZMdYvoSfrt+UnynlzPHrUbZzWERImhAhPn9s38G2L62jmFTZ1F5ZB3wG
         fX6WUYt7r0sKveyg20xQ7S5nSk0OmPHiQ2en0+MWKzl8whGB+MNN4TBUsuPyIIfl3mb6
         lfaEBwurUTXXGR2mITWlqKK3fJJD5VJef/xoigRiS83q9Q8DusdLuAu6IoPmsIyufpp2
         iMrw==
X-Gm-Message-State: APjAAAU+b5a+s8fbWb66PTYlPQXjuDFWW43gFb/4o5JGMj6FLhXkym10
        NE9vq8W1DLYL00tPYPvAIQLhEw==
X-Google-Smtp-Source: APXvYqw/NhSrzyPWPQbLnED7yGzQyzSTdlwC0odTzaM2yCGhnhMYRRPM2hqTvbDK1lg4A0bgszuNRw==
X-Received: by 2002:a05:620a:13c4:: with SMTP id g4mr30230662qkl.391.1574178139850;
        Tue, 19 Nov 2019 07:42:19 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::c7ac])
        by smtp.gmail.com with ESMTPSA id i17sm7188612qtm.53.2019.11.19.07.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 07:42:19 -0800 (PST)
Date:   Tue, 19 Nov 2019 10:42:17 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com
Subject: Re: [PATCH v4 2/9] mm/huge_memory: fix uninitialized compiler warning
Message-ID: <20191119154217.GC382712@cmpxchg.org>
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-3-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1574166203-151975-3-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 19, 2019 at 08:23:16PM +0800, Alex Shi wrote:
> ../mm/huge_memory.c: In function ‘split_huge_page_to_list’:
> ../mm/huge_memory.c:2766:9: warning: ‘flags’ may be used uninitialized
> in this function [-Wmaybe-uninitialized]
>   lruvec = lock_page_lruvec_irqsave(head, pgdata, flags);
>   ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Like with the previous patch, there is no lock_page_lruvec_irqsave()
at this point in the series.
