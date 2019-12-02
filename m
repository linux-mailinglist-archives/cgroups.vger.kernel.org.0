Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0120310EFD0
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2019 20:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfLBTLF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Dec 2019 14:11:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42473 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbfLBTLE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Dec 2019 14:11:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so865556qtq.9;
        Mon, 02 Dec 2019 11:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Cwz6dYY9z4DxZQ5/f+vTSU4IwIt72HsTGUbyi+vmDkI=;
        b=eHpXuxnoiIv7Vq2GQyfaaWZbunEntyK6amEKPxAgDXh2F7i6pgY5JOrOxmRYBWA/bK
         SLP1DHchXwPfowdj5JvhSMqHWJ7QFOLj7S2hSIL6q74qGRvBlMbVhdd4v4Zy4ytfu78z
         UeCcDaZGD86MzV5eApmB6/1ivXULShR+kN92UZjAxReIvbkora7ad9nnH48Ft6hy1IGB
         olUfx22vze29Uq/6Ds41WgDpod/ax0ksHshy1zaH+DEUGhmxJeAa06AQaEhB2fDCukYe
         htwTeqMbepZamefzWks0AUPXeBloI9/BFb2Y472dRAJOIRWU41rsOUmWavuiJf9QETF5
         H6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Cwz6dYY9z4DxZQ5/f+vTSU4IwIt72HsTGUbyi+vmDkI=;
        b=iNFpKIzq4nhD/jF6u8QGpkirLbcT23v+bRQjLgkSQlzrkQmUQ6rFrLFzaKmdJXUxcT
         h30xXIwQ3UKoLgmcF3D0tXfCWM6Dz89cj/LdKo4oPEXPzqrePRsEnsldXm4ET0q4ovjW
         4ipHMM1LCv4j8Tw8RTl/eaMZSYhVFv9m80DMc4/Jz4aeo98yS4/7+Wh5zJv1wXSYlNGc
         S/MskOBQ5HyW6cFLyGOnVYO/X9ussVl4J+RUhsOt0npHo0MaDfZdBAnysY2rmiqkXbeb
         fzJhHez7/O4WCtKuwKlZhrwSpQ/pssyvl7hEw/Czr0JbRnO7IEhxVwGEQHle3YXDen7A
         U6sw==
X-Gm-Message-State: APjAAAWvxfvzXg7KkiTxHRpT/BqiujHZMKYd/7s8ESAEXWZauLan4zBz
        ejqXUU0pSz5aaAxxU+CWTxE=
X-Google-Smtp-Source: APXvYqx8mht7nynmOddR27kQYNBnjL0lmPtURqUSmMWCZ7Pxu9OQ7QGVWDcztUiQd3M9LLP//0a/4w==
X-Received: by 2002:ac8:745a:: with SMTP id h26mr992039qtr.192.1575313863412;
        Mon, 02 Dec 2019 11:11:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:c909])
        by smtp.gmail.com with ESMTPSA id s189sm269559qke.41.2019.12.02.11.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 11:11:02 -0800 (PST)
Date:   Mon, 2 Dec 2019 11:11:00 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] cgroup/pids: Make pids.events notifications affine
 to pids.max
Message-ID: <20191202191100.GF16681@devbig004.ftw2.facebook.com>
References: <20191128172612.10259-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191128172612.10259-1-mkoutny@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Nov 28, 2019 at 06:26:12PM +0100, Michal Koutný wrote:
> Currently, when pids.max limit is breached in the hierarchy, the event
> is counted and reported in the cgroup where the forking task resides.
> 
> The proper hierarchical behavior is to count and report the event in the
> cgroup whose limit is being exceeded. Apply this behavior in the default
> hierarchy.
> 
> Reasons for RFC:
> 
> 1) If anyone has adjusted their readings to this behavior, this is a BC
>    break.
> 
> 2) This solves no reported bug, just a spotted inconsistency.
> 
> 3) One step further would be to distinguish pids.events and
>    pids.events.local for proper hierarchical counting. (The current
>    behavior wouldn't match neither though.)

Yeah this is incosistent with memcg but there max / high events are
essentially useless because that doesn't indicate actual limit breach.
Both events are interesting - which cgroup's limit was reached and who
suffered because of that.

So, maybe sth like the following?

1. Make max event propagate hierarchically.  This is a behavior change
   but also an obvious bug fix.  Given that internal cgroups don't
   have processes in cgroup2, maybe it's safe enough?

2. Add another (hierarchical, of course) event which counts the number
   of fork rejects.  I can't think of a good name.  Any ideas?

Thanks.

-- 
tejun
