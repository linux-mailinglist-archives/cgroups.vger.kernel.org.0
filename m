Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8897121B04
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2019 21:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfLPUnz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Dec 2019 15:43:55 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42090 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLPUny (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Dec 2019 15:43:54 -0500
Received: by mail-qv1-f66.google.com with SMTP id dc14so1645488qvb.9
        for <cgroups@vger.kernel.org>; Mon, 16 Dec 2019 12:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zqE26/mbXzQv3y7uGbCv1mg1k2hpGS4Jc7KoDB022YA=;
        b=KGf5+ssP31BgRZic4xrTGcb5MG0BA7QvkmVvaGFSzlQGLaeWopyqfrvbAl0tYafHrt
         245XG46vbDbb3c2qmLrdp14kJqD1SPed48Alqk7meVdcZeuNYtkqO44xAsaDcExCevNp
         G5WbpDvReKmTlW+3gqCzNynqIsBRBVA+QXrvTA6QGLEWbYvg6mnUlV+lUDv0+SkKk3OM
         0ejq6Jr1KDRUYH/5ZTzMMWfLYLgq1z27RVocd6CZi64ks0toJCmbJyA8BdfPQbsQV04o
         Y+Nd8jAEFtfTKwDkfGcj1z9aVN9wN/YcPE829CLSd2DFMZDt1uzzm2SaXYpCBl0ZIFB0
         OEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zqE26/mbXzQv3y7uGbCv1mg1k2hpGS4Jc7KoDB022YA=;
        b=afBVwUcP9xDABNdKNHiXGWB/Jv6hzqk0DrhSdj22FbgUl2APKPvQnzOoq2BqIuMI8Q
         zuRUomhiLaVLSPjGc8I9MIK4PyNZyuzomznG/ggHTn0zOofLpLcZIZ9bktnGGszoIyEY
         6w3I3B4zK4OEOMCXG1EGFyfC1A/p8uvRSGSw+IdCWMINUwbgi9JEn+pEy8UKm7ZZ9U6I
         Ugo37Bxar7swhnUv8d4uS49w8pk4OTd7WRqX8wGavVyQLSc8Dkit2fXq5OhiA1EjMFnV
         SfRNCY2BWiZojkr3TgRON695AFpq3r6omWZCKrTuyikCYCRygIwzGYlAbLPG+7Til04Y
         vLUA==
X-Gm-Message-State: APjAAAWA0cgbJcjw91QvgvjQrBYBZ/Sejc9VG/0QEqOY88+xwElDN3Bb
        BtBGfIXthZWVXjR3FjJzBUpNmw+luW0=
X-Google-Smtp-Source: APXvYqzzCAHOwuwn04sSACFm1Xtqk0+v82sdrTTzBRfZgMf3jjkX5nKgGBrVc31rMu6kAwnwG4HzRw==
X-Received: by 2002:a0c:990d:: with SMTP id h13mr1249610qvd.247.1576529033873;
        Mon, 16 Dec 2019 12:43:53 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::d63d])
        by smtp.gmail.com with ESMTPSA id b42sm7465209qtb.36.2019.12.16.12.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 12:43:53 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:43:48 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     cgroups@vger.kernel.org, mike.kravetz@oracle.com, mkoutny@suse.com,
        lizefan@huawei.com, hannes@cmpxchg.org, almasrymina@google.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v6] mm: hugetlb controller for cgroups v2
Message-ID: <20191216204348.GF2196666@devbig004.ftw2.facebook.com>
References: <20191216193831.540953-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216193831.540953-1-gscrivan@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 16, 2019 at 08:38:31PM +0100, Giuseppe Scrivano wrote:
> In the effort of supporting cgroups v2 into Kubernetes, I stumped on
> the lack of the hugetlb controller.
> 
> When the controller is enabled, it exposes four new files for each
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
> The file .usage_in_bytes is renamed to .current.
> 
> .failcnt is not provided as a single file anymore, but its value can
> be read through the new flat-keyed files .events and .events.local,
> through the "max" key.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

This can go through either the mm tree or the cgroup tree.  If Andrew
doesn't pick it up in several days, I'll apply it to cgroup/for-5.6.

Thanks.

-- 
tejun
