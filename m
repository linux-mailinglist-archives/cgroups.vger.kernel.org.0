Return-Path: <cgroups+bounces-4007-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D25394210A
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 21:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4EE1C22A57
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 19:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D9B18C91F;
	Tue, 30 Jul 2024 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEu/mmju"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E813AD13;
	Tue, 30 Jul 2024 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369000; cv=none; b=GRuKhwj4f3MoqaO3qlWqzOhQgEGv9Rp1MwU8GJRYgj3BwnfPACDq2un2YcdgBUiWSDiwqttptx1SFNI6qq0FR6NG8lL7tqj/i4lHK+3e6hlLPH4FJvb2VW+0Oxi4gCByn8e/eQG7HDVvX7pR6REWIIJWm+VShfYVlHnOZMDNb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369000; c=relaxed/simple;
	bh=uW/cUr2MvcluZ2/oUSH96R6Ae5h6L0EBkLyM6UGBWlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVr4UoTXjywHzIx9YtQX8pmrriIxH+CQM6N3dtt8Zt15+mGYkUeKKJVwEIHouwLKQLTPp5mmfCM5LxYr42v8G8p1N0YOexdk828azU2QVt/ALzLF+TUF5B0D74vHGi8M2z5cl/Ec6UQp5g7bAGYilYo6envBqA0/6b4l4dg4XMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEu/mmju; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d1c655141so3546295b3a.1;
        Tue, 30 Jul 2024 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722368999; x=1722973799; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XqsIBuR2d65pkoTcMib3SHObnFtV2VvkWqAzRn++NI=;
        b=kEu/mmjuNmqqFsS7gEV0gyc4LQT5ZUE+h5EMMbUWvwOXO8PGKdaSioS5vK60Clksjd
         Nb4FYqZ8YwxjQqcn7GuWS5QJnJIJdJuI+dXgdGS5SG6NBhVrnbf9vVAbgKYZYtK7GuQp
         CICudDn552u/OYp4pOL6u4Dqrr1PNI6gxb584AkDN/wzxXAYvBW/BFGOAO5iwRsaAI46
         a5xRDHkQdZ7Ei9Vz46UltZOTt16atUF2OSohAw2/7GGm7I0fuQCvsg/984evXVg0p7sH
         wdQyjh0iDSar43MH/DatSxPpBbt56Caam1BToiW6XDfgzxrkSh8mpf2Bfv46kP4P4ZaO
         9QaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722368999; x=1722973799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XqsIBuR2d65pkoTcMib3SHObnFtV2VvkWqAzRn++NI=;
        b=EypBmviemB3VHDWpEfYLB2JeH587IHtVJHZBFbzMHUwECAk6RUGr7KRYwYP494vOEr
         G18r35yGknfMo9sBVhsw0nl/htI82Cn46hQUWOUJtddi7NsXwKj5UILYbz58nGfW/zno
         7un5GA31la4XU/cTTkutNK8d/gq3GyksaOKmCISTMchaZE98Qe9XgzGWmhEYu4krqRDk
         Myf2R9OQIPYspJoWVkjRe+E7W8WQINjv3sKbXN2zwrXfZqmB2s6EgjxZz+8u43ZAnA4k
         lcpHHd4Yz45JZ81rWas8MzP3UdjmeG/o3RuRZKHNkNZbUouVd8BoZ8gQpTRMVRXnR+iI
         +/WA==
X-Forwarded-Encrypted: i=1; AJvYcCVygkGjaPOT9rJnbIB5wRAR+HyQg2nuFnk1/dOqwGV7sQeq1CxNPAblSvnjk52Q8lUKhuKzgsY7GqF8aM8sozoSw4KR89QOQqDcqRpKOxhAjL4Fq/oOvmnR0KQp+Z5VXA2Zms0J
X-Gm-Message-State: AOJu0Yw+uwaD/jB+UMIa99QXAiVWn195GusP22sUwAZnoVcdG+3kSD8W
	8QXlMbijAjkchcXo7UVTxhIgskX6nyCd1TXBJaLoyUE8wfzbv4zq
X-Google-Smtp-Source: AGHT+IHMofISf8ufHbwXnDvSjNtSEFNZzRptii26XJJ1D92mEtUxcrKRXGJT3wiXryOSkzNe2+u7yQ==
X-Received: by 2002:a05:6a20:2455:b0:1c2:8d16:c681 with SMTP id adf61e73a8af0-1c4a13a47d7mr10418021637.34.1722368998718;
        Tue, 30 Jul 2024 12:49:58 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee0190sm105934855ad.160.2024.07.30.12.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 12:49:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 09:49:57 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: Boy Wu =?utf-8?B?KOWQs+WLg+iqvCk=?= <Boy.Wu@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"boris@bur.io" <boris@bur.io>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Iverlin Wang =?utf-8?B?KOeOi+iLs+mclik=?= <Iverlin.Wang@mediatek.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4] blk-cgroup: Replace u64 sync with spinlock for iostat
Message-ID: <ZqlD5WXx39E8xVnA@slm.duckdns.org>
References: <20240718084112.12202-1-boy.wu@mediatek.com>
 <ZpmF8HJsuefjC7Xr@slm.duckdns.org>
 <00c595a16b4e96ae56973ac2ce586f6ad736059f.camel@mediatek.com>
 <ZpqjCVxSAV-Q7Yhy@slm.duckdns.org>
 <e944e61fb64e5094aa6a0afef652359734619ba5.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e944e61fb64e5094aa6a0afef652359734619ba5.camel@mediatek.com>

Hello, Boy.

On Fri, Jul 26, 2024 at 03:43:27AM +0000, Boy Wu (吳勃誼) wrote:
...
> The use of a spinlock with u64 sync is suggested in
> include/linux/u64_stats_sync.h:33.
> 
>  * Usage :
>  *
>  * Stats producer (writer) should use following template granted it
> already got
>  * an exclusive access to counters (a lock is already taken, or per cpu
>  * data is used [in a non preemptable context])
>  *
>  *   spin_lock_bh(...) or other synchronization to get exclusive access
>  *   ...
>  *   u64_stats_update_begin(&stats->syncp);
>  *   u64_stats_add(&stats->bytes64, len); // non atomic operation
>  *   u64_stats_inc(&stats->packets64);    // non atomic operation
>  *   u64_stats_update_end(&stats->syncp);
> 
> Is this a incorrect statment?

That's not incorrect and it'd make sense if we really want to use u64_sync -
e.g. the reader is hot path. Here, just a spinlock would be simpler and do
fine.

Thanks.

-- 
tejun

