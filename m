Return-Path: <cgroups+bounces-11202-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B52EBC11DF4
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B40835410A
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 22:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1E32E727;
	Mon, 27 Oct 2025 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3bOrsLM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC45334686
	for <cgroups@vger.kernel.org>; Mon, 27 Oct 2025 22:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605185; cv=none; b=dGlRBbEJopOLjwcJqoUoE35QJyW8ZrKm/yjS1zVB2pzw1KXsuCq2c7ce6FrN1Obvd4vftD2l5OMy1kvenWUloW+NR3Ly/vcu33nC6MD5F14+Pbr9NXozoIhoT9Ijb1KSAs8VhmPIp294i9xXec/XVGlQhG3r2zca75CAXzQm8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605185; c=relaxed/simple;
	bh=YbNF9xBLgvPcEJ73q19bteNh3qQ4EWHWmqaSpEAAHPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyU3XKWNgm53O3bMwrd/xNUmKFR9aE7mecG7jeAGKyNLqr5nVYi7or30ClEOrj1m2QF5weMFCwhl8nFZsoCZkNsLlznJQ6zZsqA2aMRafNhEZAgaKxkBMOixrGMrakmp0audsG/ghSR+hya3q4stjboWGFjSXl3Nkt2drJJSXXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3bOrsLM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so31384025e9.2
        for <cgroups@vger.kernel.org>; Mon, 27 Oct 2025 15:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761605182; x=1762209982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbNF9xBLgvPcEJ73q19bteNh3qQ4EWHWmqaSpEAAHPI=;
        b=R3bOrsLM90ph+zhd05Sn7igSwGIPADBCQVTuFiwym7wQ8MlicFuMlUzlwD2gBHkY3f
         1KuwPuFQ8RbZMqTBSMUpT/qtBmK5aMAQ7cc0iuJVDgU5uJ2JP8ELO+8oOF9euAndL0ZV
         z2KYBXeHISmwQsR38TzkRPbMniliWRieXTugL++3ur17WWTnGkzyWiuGywC56NZcbsDg
         cjbrKZy+OqahFx7qRKsT+L1Xl6g3ibUFErq/MNJguA8hRjaxIMnqHW+y3JV1JUvGjPH/
         +5UkA1HTvjPxAFujFHJBPFPWPsFWNbOUUW9S6zQhcecFM0Z4hIzTmG4E9iGm+Wo72lRi
         APZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761605182; x=1762209982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbNF9xBLgvPcEJ73q19bteNh3qQ4EWHWmqaSpEAAHPI=;
        b=M6NVxiDg8pveoc3snCBmhH7B6+mn2pc5oKXw0XGD5saRM4AqRKQ6r2R1AKLYkgTNri
         L0uFTQvkeszvaD79cjILsMyIaZp93tMuxnriWCRQtXLoBq67jvkWX99PKeusJOdBIIgh
         kxSBtfzg+GcNK6hYwfKttSuxz3HwxwUZD3X7Awsvvf9uzQjZBC+nTua1yIbjdqQq5ZX1
         AoscHmrpVGW27wlUytbURVDyVtEkoreaGFUOXqiAMdNWeIfy5qCwyiduijjMyV1S0oFi
         2HqksV0elX467xJpbiqflFEcfVNvuGW6npnRsVXBtKVu5CfNx4/mLgSctgHBtCdX1XKu
         RqyA==
X-Forwarded-Encrypted: i=1; AJvYcCUWG50Zew9L2jrxdj4B9tBA1Ef8UpoNa0ElH0nDncx7kTyoi8no0bcSSZG+018/AJY9qcDQM/1I@vger.kernel.org
X-Gm-Message-State: AOJu0YysAZnYtcXQxaxlp5D6+DdR4PN96mOQg2c0E8mPBF3XwHVfDC2b
	wWxm6Vejf7CTCpQKnvPOcLI+SuR2lqkQ8GMNaHT89Yvv4imnAJ0uIEHF20q/TzYMjNLKcNJPOax
	ChqEZ3xxRibvkRTjjVAgvxfBQibnBljo=
X-Gm-Gg: ASbGncuUvyknFi0d0FmIfwHKBzLPwkIvQRMSiNy18Pq8I7DExGEw1+1lH3El1ij9Kja
	/4vVbZho+B22bJlexIS7n5prsigg18ofJ9hck4Y/HA1STgbMO3vXscHnsqn0rODekJ0W0QkKit6
	2JXgSfDO2HqELDPgeifIg/ZhXgRakJwHM9EE2WU3hGgImp3y1PbgvQWGhl38vSZatQ5vV2Z11o7
	LsfjevT9ugf37fPWTaEQIPNL1kSsy95rDFMcaeAeF9iWCJ5iha/GxPhE0Y8rXj3xBkYmQ==
X-Google-Smtp-Source: AGHT+IEeNWo2bsGLLqGLfQNsY0L6lNVZZ2khSDzRsqsRr6Jo8tC6B0Avoq1yBzRM+ieeQ79ZgiTz+pEgGuOt7PLnUe4=
X-Received: by 2002:a05:600c:46d3:b0:471:1415:b545 with SMTP id
 5b1f17b1804b1-47717def6demr11070845e9.7.1761605181955; Mon, 27 Oct 2025
 15:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
In-Reply-To: <cover.1761439133.git.jinji.z.zhong@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 27 Oct 2025 15:46:10 -0700
X-Gm-Features: AWmQ_bma6lyHlpvPtwTt1egk70m2KnBJDjgat6AjIDzKFfoBCYrn6d-bXve4s8M
Message-ID: <CAKEwX=MqsyWki+DfzePb3SwXWTZ_2tcDV-ONBQu62=otnBXCiQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Introduce per-cgroup compression priority
To: jinji zhong <jinji.z.zhong@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, philipp.reisner@linbit.com, 
	lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com, corbet@lwn.net, 
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, axboe@kernel.dk, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org, terrelln@fb.com, dsterba@suse.com, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, 
	drbd-dev@lists.linbit.com, linux-doc@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, zhongjinji@honor.com, 
	liulu.liu@honor.com, feng.han@honor.com, 
	YoungJun Park <youngjun.park@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 6:53=E2=80=AFPM jinji zhong <jinji.z.zhong@gmail.co=
m> wrote:
>
> Hello everyone,
>
> On Android, different applications have varying tolerance for
> decompression latency. Applications with higher tolerance for
> decompression latency are better suited for algorithms like ZSTD,
> which provides high compression ratio but slower decompression
> speed. Conversely, applications with lower tolerance for
> decompression latency can use algorithms like LZ4 or LZO that
> offer faster decompression but lower compression ratios. For example,
> lightweight applications (with few anonymous pages) or applications
> without foreground UI typically have higher tolerance for decompression
> latency.
>
> Similarly, in memory allocation slow paths or under high CPU
> pressure, using algorithms with faster compression speeds might
> be more appropriate.
>
> This patch introduces a per-cgroup compression priority mechanism,
> where different compression priorities map to different algorithms.
> This allows administrators to select appropriate compression
> algorithms on a per-cgroup basis.
>
> Currently, this patch is experimental and we would greatly
> appreciate community feedback. I'm uncertain whether obtaining
> compression priority via get_cgroup_comp_priority in zram is the
> best approach. While this implementation is convenient, it seems
> somewhat unusual. Perhaps the next step should be to pass
> compression priority through page->private.

I agree with TJ's and Shakeel's take on this. You (or some other
zram/zswap users) will have to present a more compelling case for the
necessity of a hierarchical structure for this property :)

The semantics itself is unclear to me - what's the default? How should
inheritance be defined? What happens when cgroups are killed etc?

As a side note, seems like there is a proposal for swap device
priority (+ Youngjun)

https://lore.kernel.org/all/20250716202006.3640584-1-youngjun.park@lge.com/

Is this something you can leverage?

Another alternative is to make this zram-internal, i.e add knobs to
zram sysfs, or extend the recomp parameter. I'll defer to zram
maintainers and users to comment on this :)

