Return-Path: <cgroups+bounces-6108-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA7CA0BA3F
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 15:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A231F3A3B66
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 14:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4EA22C9E4;
	Mon, 13 Jan 2025 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ttsfd9qb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FF23A0F8
	for <cgroups@vger.kernel.org>; Mon, 13 Jan 2025 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779660; cv=none; b=L1naFzIQc0F6HfFDj4YnffiC1fhkCxYD/dho8z9tft90eO6gsVLh1Jom3ZJcZcFb0Ka9FIoISkU0BLLXv4+FGJ71q8f2wTLGZ/W3O0ORT3gRPKhsAvx+Z2T+nrm17hdExXrMv2IidLd939dvwvCltoF06U+EdgciPfAqyvLHqJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779660; c=relaxed/simple;
	bh=3tjGVV08o2bpb7T0UYjHEQ4bbZxoNR7ms8YvttGwRIo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HWJCrp98aZMY99kbNXkRGPfZ3VFzTizMtwbVDnLp+ldbizOkso9xQSlb2j6wCcQ6ZH7lKGQDGCgJ23Xm01xja8Hv4e0xg7Ed1aTGYRZTeJBv5iD3PC4EYYhNfMv0mpnlZcOyimX2GF2/4hpYVdiWwUCGOF1OdS4Ws0sN1so6/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ttsfd9qb; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844e1020253so146754739f.3
        for <cgroups@vger.kernel.org>; Mon, 13 Jan 2025 06:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736779658; x=1737384458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ct4Iuy5ssYGDDfyGiWQYiwxiSnqVWA8sWTzSYRjyxC8=;
        b=Ttsfd9qb3CDvXWzD0nODPdVEFva6gHA8eIivbKRv9oo5cA0x4I/6QGa2LnqLg6w3cs
         oH4z4TTKBzOmJZykOa5v98mhWbDxUbC0WGUk+yUeAHkiG5Z7C6a7AMDhq+cvfMJcqb1x
         kMmvkKkJhU9z2KfyHRuY6DSWq3+DOAowv1y6N2Am5CNpPUgbFoIBBCfbjE/JRZcXyNbA
         gbQhiv3lxR5MOIyjy6LXYnxRkxr1AilkkvfSSukHP8IeefhAVerYoxhEVKUpdo0XZf47
         i+kmhNJXgeuTy9wszYbG26UGWhwYgQH1QChj9Ygv7wqtM9P/cORg8F4SN96GtsYsatsT
         Sppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779658; x=1737384458;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ct4Iuy5ssYGDDfyGiWQYiwxiSnqVWA8sWTzSYRjyxC8=;
        b=cfDRsNZEVqpj2v3lPUkpFmYZVjhj+bjDZZTJ2EpjcMJdNgqHXDDMEc+34jcERJX0qI
         4cUlZhvv85wqAqAjEb9MX7zullrBcINeZsZHGCQrrLA8h9V4lj3175Wf8ybfGmVNxz/k
         DKnBOH8YmY52AyutDhHtWCAU13SKMAEP4WZ3jMZgy+8Bgb9m/xGAbPzIK/1ffD8hzQZP
         xuIIw+3ZULfwWD2HWweXOfl7731VIxM0ewWyZ3YXEH5HuQRS65WpSUo/VExBwQ0+USJy
         8jl/a3r4beXxkQ/tnuJrj8AXDmykjaVsfvQQWd/9zsQqya+BQCyIdaBDUjWPlQUeqRHb
         lCfA==
X-Forwarded-Encrypted: i=1; AJvYcCUXbtVMYpMVs8lGT/967DC2cDXKKMbYsxHH7cRlXOABu07DFcX4uTt5EJ7OlKx1ru2WSECyTedM@vger.kernel.org
X-Gm-Message-State: AOJu0YwyIN21rQ0U9mT+mvuGeK+p4stlGPasHVeDYisjC0rjn4fdFMA+
	qPGW/HJwEWuPeRVLRej0j3KATEIjsvTE+v8wDwpm887DHZ51X+oLZi9PUIhao4E=
X-Gm-Gg: ASbGncuh15NCqBUbiIFJWRvZC3oJFD8WZC7M9xnilJ3TjMcbKE/qg3wxSxYGQ3U/kvm
	tz3PLjymFSWHoU4NwWS/+sZaGPFNTbLkt7XNgeP55k90pluZZn5O2ImYw1r8PtbWZd1KUqhgMzE
	8SnQHpx0aM7lf329nm9zg0Er+TfXSDSyg1uAePMsloNWbLn0ufglnfBOCHQvlSMPwHeL+xQfHpx
	ye6L44M58lMdLEIPPSSIKoLIXPQvqoRhJLiiEQxl14uFQU=
X-Google-Smtp-Source: AGHT+IFUkBbeeOx2e+HVkHy2G5WuzcqIZ0M7VyDn/3MtrPSV4vWvMlC2PHbhksx8+sm1qjrdgAG3Ow==
X-Received: by 2002:a05:6e02:198e:b0:3a7:8d8e:e730 with SMTP id e9e14a558f8ab-3ce3a8ec729mr147588965ab.22.1736779658334;
        Mon, 13 Jan 2025 06:47:38 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b7459e9sm2768810173.118.2025.01.13.06.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:47:37 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 cgroups@vger.kernel.org
In-Reply-To: <20250111062748.910442-1-rdunlap@infradead.org>
References: <20250111062748.910442-1-rdunlap@infradead.org>
Subject: Re: [PATCH] blk-cgroup: rwstat: fix kernel-doc warnings in header
 file
Message-Id: <173677965739.1125204.17578281446586670021.b4-ty@kernel.dk>
Date: Mon, 13 Jan 2025 07:47:37 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 10 Jan 2025 22:27:48 -0800, Randy Dunlap wrote:
> Correct the function parameters to eliminate kernel-doc warnings:
> 
> blk-cgroup-rwstat.h:63: warning: Function parameter or struct member 'opf' not described in 'blkg_rwstat_add'
> blk-cgroup-rwstat.h:63: warning: Excess function parameter 'op' description in 'blkg_rwstat_add'
> blk-cgroup-rwstat.h:91: warning: Function parameter or struct member 'result' not described in 'blkg_rwstat_read'
> 
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: rwstat: fix kernel-doc warnings in header file
      commit: f403034e8afd12ed6ea5de64f0adda3d90e67c9d

Best regards,
-- 
Jens Axboe




