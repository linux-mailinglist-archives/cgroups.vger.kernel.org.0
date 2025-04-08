Return-Path: <cgroups+bounces-7433-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB28A81263
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 18:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A204886172
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A483F22DFA2;
	Tue,  8 Apr 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glPRGl/d"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF422D7A4;
	Tue,  8 Apr 2025 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129659; cv=none; b=PuCaGa6BSdp9HbqM2n4DLOcCJrfwGfRctl1YVcdyD3eh8TSjDZI443yd7zOrR4q4Qz7xS53QLtA2Ae34WwpDGKe2noml/WoHNPFMGcqVuW++mPh+YnUmWkl+dXyjMDrSjqcJyZ+fhx6eGSztln7dqWn3CtrPJ3o8Xnw6Q6DCNFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129659; c=relaxed/simple;
	bh=fuFIxc3UmEgiGu4Oa0SVwDPBaqZrTG27mMIS2ft7hRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXoltIEYvn5Hw+MiRHwnMQM8KR29+ciqlGXeVXqcjgOdyUlxRHHMg1SZTke14U25c8XNZa8EP5KSY2VH3sofzFUaQiSFJP8pQsNPJQHtif7nv2SWoYM8ZTYH2iWwB8QI/0ANUy0x2kJ9OcjWvvBfRZcjixy8z4OlVuUhr+1AD3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glPRGl/d; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ecfbf8fa76so67820006d6.0;
        Tue, 08 Apr 2025 09:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744129657; x=1744734457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuFIxc3UmEgiGu4Oa0SVwDPBaqZrTG27mMIS2ft7hRk=;
        b=glPRGl/do5QbnFbzhUg5m0Ln+fV5Bm7ABc9wDwiMSdImqEgxoQGw0ubl7y6jZH1Y0K
         7dg7KZh2Lg/yH2QBw1Wcx6jwytHTTvAhmO5fD0xAVC7Z2T5z53Yh5ruUGabP32YbBRJu
         MfESB+fyH/LkrRMNMBgnqq7OaKf4wIDM/LnCG4eqaMxZYmgSZmZvAYmbXkYrvXBMJrCb
         S5MXUsHuBUA4AjfJrvbtR6OoHWyBcFC11bPbK1i/4FyaBrvdD2UaoARD6LCJDnVLd3Xn
         74AXsXRZWvDMGm+QOunbikanmob8bvCY+ivHdBD5sHMbT4Nnbn80Zz2dvxbExydOCBnn
         XgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744129657; x=1744734457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuFIxc3UmEgiGu4Oa0SVwDPBaqZrTG27mMIS2ft7hRk=;
        b=M3J9CJQyOoNKUtD2ECP5IomI9hrm+FIpTELfjch/ODL2eJYf7TzhGy0+tmKZTLhAGl
         8uIVEnZWuVF64k3gG22ERKEFT87F2F+/QswRCgjJlOHdt+KcXoNbNkYRZmLDcYb1IjbT
         q6u0adetp41nYNMx33vKvSFu9JD+0jE4Qjm9Tet7C0SIusG1dumo+ip2Bf4JjB9zQzzC
         5qysfdiMffojLfB1wFNmIz0IcyDAG8s4KOT2TC6vi9s4yGPQOZayPtioRCNgwvdTgrS4
         UTvKGJPtOno+KrC+hV9hsiM+k80lfDvAhnMhE9uDhMXO1rhZpjNpwq/7I6y5Jxmy++/9
         YHFA==
X-Forwarded-Encrypted: i=1; AJvYcCVdVE7SRMLPYod8R2VcZkw0jTBOtSfVcy72YgEQ97xrDdKSOmnxHK9wtNM6usuAAu+0Xk7A3seRkfwlwRue@vger.kernel.org, AJvYcCXf7grkBLPBc7Ue/2PgEiWv5he3JZdYCmEOSKYwfJpLXjgsH1Oa7oTjiqqGjxil3Aotw8Y5NnXmfic=@vger.kernel.org, AJvYcCXsApU6THbsTCChxliCnfLha3yXJTPwoOHcqkVF90vHNOP7dMpzjEyzkZRW4vG04FapIxuJHQbm@vger.kernel.org
X-Gm-Message-State: AOJu0YxKCG/fi7L8/38UnNwWsQDoXveOoIMxlXUL9YYrgkmIiNFIW3c4
	tcPJj6AOHCeWNcRBp+eDYyUHyWHt9ps6u6JyTQGOKCoXezZLWMnITM/D79BvdfSIhOTu0mnCvyk
	ZMal7ehNPdKTRczYsX7M0RXP9it0=
X-Gm-Gg: ASbGncsjn7g9Wmd/Y6xwHXS+xXe7YRviU9asSkguskMOsXi0qDGioLg3sVmYMKm2W9g
	AYAYww7JKgKYJzx8841LeEdpEAx8zENeVH7s00m4z0HMy7nn4QbarvA89lHtRFWYnQ3g3bNieNc
	7HajOF7WsnHeH7dbC/qaP3bvy9zX0sFfcLoePf0VztYbGUbf4kz97XSe+pjxhUSeOImpy+
X-Google-Smtp-Source: AGHT+IGFsALA7aRqU/W+C/93GMoSwJDaDaxdguDqfpdfePBPeTRNr31OpKPkzMEXpcXrvTG45eGI2Zdb73VRAPZ36cE=
X-Received: by 2002:ad4:5cee:0:b0:6e8:f2aa:a8af with SMTP id
 6a1803df08f44-6f01e7bbc76mr306272746d6.38.1744129656879; Tue, 08 Apr 2025
 09:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407234223.1059191-1-nphamcs@gmail.com> <983965b6-2262-4f72-a672-39085dcdaa3c@gmail.com>
 <20250408154547.GC816@cmpxchg.org> <CAKEwX=M3do_7SJGKwfZQ8vOSQN4aM1ZU04Q3E99CW=UTCkUMOQ@mail.gmail.com>
In-Reply-To: <CAKEwX=M3do_7SJGKwfZQ8vOSQN4aM1ZU04Q3E99CW=UTCkUMOQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 8 Apr 2025 09:27:25 -0700
X-Gm-Features: ATxdqUEYusevCFnCKyMm2x8ip9PTzU9SuYSWaXB61KPZF6jEk2iOHt4bxRrqZ-E
Message-ID: <CAKEwX=MAeT+ag9mNq7-yfVBzgGQ7y+SN_p7DQnto01TG33EAPQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Virtual Swap Space
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, kasong@tencent.com, 
	chrisl@kernel.org, huang.ying.caritas@gmail.com, ryan.roberts@arm.com, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de, 
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu, pavel@kernel.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 9:25=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
>
> You're right. I haven't touched the swapfile swap map and the zeromap
> bitmap at all, primarily because it's non-functional change
> (optimization only). It also adds more ifdefs to the final codebase :)
>
> In the next version, I can tag on one patch to:
>
> 1. remove zeromap bitmap. This one is pretty much straightforward -
> we're not using it at all.
>
> 2. Swap map reduction. I'm like 70% sure we don't need SWAP_MAP_BAD
> state. With the vswap reverse map and the swapfile inuse counters, we
> should be able to convert the swapmap into a pure bitmap. If we can't,
> then it's 2 bits per physical swapfiles.

s/physical swapfiles/physical swap slot (3 states - unallocated,
allocated, bad slot. the latter two might be mergeable).

