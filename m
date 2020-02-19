Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6075B1651B6
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 22:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgBSVdi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 16:33:38 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33007 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgBSVdi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 16:33:38 -0500
Received: by mail-qv1-f66.google.com with SMTP id ek2so919123qvb.0
        for <cgroups@vger.kernel.org>; Wed, 19 Feb 2020 13:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JVkD5nxiTD0qf2+tDsHsfNYWqcQb37JvAO77tIsuHko=;
        b=KHQvflBumvT9ocn+DUGF92g5qIEYXn4RpN+sBAiiGI7qDTLMDNvmMXdzmPx07tdVC5
         Z0jvJ9KvD3Oz7dzhrCjSoFhzzkkoRZ5cfSGee6fXlC4SGMn+qcgJb69EApxW+QV0Ithg
         yFxee/9aU7GZEi96Gqkjtz9aGbnDEFfrQR2RtxW3VYOlLw45JSNOGyp0Qo2KHPO4KTEF
         fO+TS/HO2EgULbw5hfQWr8Ui6ZzSceXUwwZI2AQcNjv8OJCCdE9TwIsToHxrKor4ndV+
         a4UIjjq/mOCYYiNdlRbZawGhrrSJpjoQsKrEzSmsPSJkWMOrGT7A5yXMxtog1VXEBgr6
         GCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JVkD5nxiTD0qf2+tDsHsfNYWqcQb37JvAO77tIsuHko=;
        b=RiIw0LNv5gN7hSM1Zwe9H6HEiiF3qhAXEKCvVZJ6B2lGapkXjWFMUF0w6gqc8ISWIT
         QWLIycGjw/ktEfdBvnAzPOVk/QkNkznrEjyBp3DICsNzXIr4kuSIOI2NDa4B9Po9c7TO
         YUg1FzXChMtk5hBmz5n5Qq1D/lUn847w/92/RAFYl8KW0KqZaxLM2cBYnSKpC0RrmAJs
         w+qCCXAc/sg6ao/Pt4N8iWwMZ11gJZ4Fm1rLZoo0yb+RYAX9EFcL8YDgQWtavweqqb+1
         MMjGq6ugNVbwRFoOa6hvtWkpLp0QWkpc/4pYWMJP82Bdsri6Uu4c7le5PKHLMMUEr/+B
         yqcg==
X-Gm-Message-State: APjAAAUzbf/OqAXGPLSqM4Rpn+hjGNBvf1jwJkd/ek4k816ncLOgUXcb
        g7KummH0/a5/6NmWY8Vrxn1K7g==
X-Google-Smtp-Source: APXvYqzEXXsR5u3FJN/PyxBmZtf/Z8ndTXA0RM2zBRR4GY9UMh7JsgHW89x2UTENdKZ+5MLtTmbR5A==
X-Received: by 2002:a0c:e2d1:: with SMTP id t17mr23178016qvl.25.1582148017323;
        Wed, 19 Feb 2020 13:33:37 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3bde])
        by smtp.gmail.com with ESMTPSA id g62sm512111qkd.25.2020.02.19.13.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 13:33:36 -0800 (PST)
Date:   Wed, 19 Feb 2020 16:33:35 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200219213335.GE54486@cmpxchg.org>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
 <20200219113139.ee60838bc7eb35747eb330fa@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219113139.ee60838bc7eb35747eb330fa@linux-foundation.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 19, 2020 at 11:31:39AM -0800, Andrew Morton wrote:
> But what was the nature of these stalls?  If they were "stuck in D
> state waiting for something" then that's throttling.  If they were
> "unexpected bursts of in-kernel CPU activity" then I see a better case.

It was both.

However, the workload was able to perform with no direct reclaim
activity and no stalls, while memory.high semantics were never
violated. This means that allocation rate was not outstripping reclaim
rate, just that both of these things happened in bursts and sputters.

If the workload isn't exceeding the memory.high grace buffer, it seems
unnecessary to make it wait behind a reclaim invocation that gets
delayed on IO but will succeed before the workload comes back for the
next allocation. We can just let it get on with its thing, actually
work with the memory it just obtained, while background reclaim will
free pages as they become reclaimable. This is a win-win situation.
