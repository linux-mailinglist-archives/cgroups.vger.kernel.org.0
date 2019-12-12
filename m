Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD611D74A
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2019 20:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfLLTlw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Dec 2019 14:41:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36374 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730284AbfLLTlw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Dec 2019 14:41:52 -0500
Received: by mail-qk1-f193.google.com with SMTP id a203so126932qkc.3
        for <cgroups@vger.kernel.org>; Thu, 12 Dec 2019 11:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qULa77Fim4o+A/5suU7SUQtdhblJpR3GCRtmRhMPXBQ=;
        b=cGGe73FW5enkspHCpWRecS2/bzy9BGEhcjX+9OaXVWPfijpiOdPw+MTJlEwOtmRq57
         oDm7Y8c64JjLQWUakEkwJv5psBGmB/ydaTvTSmIq4LEjWgtN9CN6FHm+gzJQqp4RoRxb
         Ky4/O5GbuoldD8elIxk0nBAxTRTXSblS7bNsR1sR1fvn/aWzC9kqof+OqqBHrsfGZNE7
         uWmz15o1sAwJ6/OF/YhjVhYiY2PyEYS4kX/mQ5asKvVWZL4jJ3e8wr+j8WpZrUpXi5Xa
         Qf5gPn4gpCewEIezZo9mJA8f5NVj8scMf+Jd9yJYOfznVMNqCy9dXM9KVSh+BYAlyd+E
         fftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qULa77Fim4o+A/5suU7SUQtdhblJpR3GCRtmRhMPXBQ=;
        b=LrgrlGbOAD3VilbN9i1W2mPKx5dzKxvoffjrS3w6gsFuVZfvvs9hd59QYFz84+zcVt
         CzjvK+PlDS2PQfuD0q0rzlq6fTZieaDdwpDQzga9Xn1KvspmT/Df6jbdGP3LSRzAG1Uk
         ZsZuzn60btvvjYOQwEJZUncJs3Mz/hOaGxeIpIZZ4cq844+Zwy83XcJMWDtdm5+6nvlP
         bmdmwVGYzvsD3lxErzCYwKgmeyHOuMhzmCIjq6guysul8QQHghX0TFlmjVQhHQX722CY
         x3LtiARImcb1KIlLyUQJo29f1UAv7LCB/tN/dvZIkrBgXONd4nTpQXwuyyvsWIj7swGZ
         hezQ==
X-Gm-Message-State: APjAAAXN8vLdcFwcVceTjj7kj1ZuF2foWtS8tCrj3gn3JrSVQej60VAS
        jTWcDcH5M2LqLaxLsY+4Y3fcVQ==
X-Google-Smtp-Source: APXvYqw6EI7Ag6g+ICIjtM7OgYTiCmzzz7lNuSv3eWLgy72Ig3c+5SPyfOrPFAARZs77/pduNIGVkg==
X-Received: by 2002:a37:6313:: with SMTP id x19mr9496373qkb.443.1576179709864;
        Thu, 12 Dec 2019 11:41:49 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::380a])
        by smtp.gmail.com with ESMTPSA id e64sm2461928qtd.45.2019.12.12.11.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 11:41:49 -0800 (PST)
Date:   Thu, 12 Dec 2019 14:41:48 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     cgroups@vger.kernel.org, mike.kravetz@oracle.com, tj@kernel.org,
        mkoutny@suse.com, lizefan@huawei.com, almasrymina@google.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4] mm: hugetlb controller for cgroups v2
Message-ID: <20191212194148.GB163236@cmpxchg.org>
References: <20191205114739.12294-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205114739.12294-1-gscrivan@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[CC Andrew]

Andrew, can you pick up this patch please?

On Thu, Dec 05, 2019 at 12:47:39PM +0100, Giuseppe Scrivano wrote:
> In the effort of supporting cgroups v2 into Kubernetes, I stumped on
> the lack of the hugetlb controller.
> 
> When the controller is enabled, it exposes three new files for each
> hugetlb size on non-root cgroups:
> 
> - hugetlb.<hugepagesize>.current
> - hugetlb.<hugepagesize>.max
> - hugetlb.<hugepagesize>.events
> - hugetlb.<hugepagesize>.events.local
> 
> The differences with the legacy hierarchy are in the file names and
> using the value "max" instead of "-1" to disable a limit.
> 
> The file .limit_in_bytes is renamed to .max.
> 
> The file .usage_in_bytes is renamed to .usage.

Minor point: that should be ".current" rather than ".usage"

> .failcnt is not provided as a single file anymore, but its value can
> be read through the new flat-keyed files .events and .events.local,
> through the "max" key.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
