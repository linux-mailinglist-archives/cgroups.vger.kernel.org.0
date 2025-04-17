Return-Path: <cgroups+bounces-7621-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 638B8A92435
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 19:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35EF171CE7
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28672566D2;
	Thu, 17 Apr 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3mWB04d"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3F62566CF;
	Thu, 17 Apr 2025 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744911559; cv=none; b=r+5vp5CN0eMbGE2NIXGtcSJz4XjNj07pmpr32KGL6I+qaDmZoMFS3DfHJGJBHKpgB4NGuXAN5mFpg6qh0Xpxivjq3pOhEeXa+3PZKLMWOy0ikgEqteacf9t1xQyjCU+GsNRjPYBup8KANP29nZLcr25N7vlvyJsN4y6kFY6JgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744911559; c=relaxed/simple;
	bh=IJOCoAbfESLPGcq0s+NtLK7+By4C1mnScFdgMd+jRPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6ddj0TF9TnUsU6rCsubhoZ2suXwtLJnQajcj6+nmvOLOk0A6YCnhoRQLe+Yk7ABF1505j4nifQ6wP3R1efV16s0dPDVMFB0S9yW0YFXLx5QMSOFWW6ysrpnZVDEonZ1VT7Z563aWUfeIJg5qEr7/pD66g2FJ9C8vQ9xRp0nnPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3mWB04d; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so12573046d6.3;
        Thu, 17 Apr 2025 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744911557; x=1745516357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJOCoAbfESLPGcq0s+NtLK7+By4C1mnScFdgMd+jRPY=;
        b=G3mWB04dQNC2cRZ6dK3rvIhdzFMac5hwKu1xeA3t/aZnkQGmy/w9d0wx57IX3J5l13
         iTZsAgpY41+R4GurxgkM6R4Qu1qklFmjiZOGJiZlsjBzZtmVlwdvKHgUUBzMNjC/XGVB
         f3E32h2yuKX560vaNyhBEZ6TIEAWi/pGC9Y9JlvnACEsk15sTJZCea65jEZTdokxY0fY
         pcydB8j/Ero6CN4kS/B46DBcJSKF7jjXGKKYaKtnyxH8aRRjUDbURwydUMXXg5bGX6g/
         9RDRYulxIZp0P+zyU+9aGk+pqZIM91jdSdRHtEUnPdCy9wiM3v3n2DG4V4uaLc8GayCo
         bxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744911557; x=1745516357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJOCoAbfESLPGcq0s+NtLK7+By4C1mnScFdgMd+jRPY=;
        b=K0uB+U2s/LPM+GHrT/Zwqc+6tt3SxnAQkL7Sz9aKTYY2ZjYTaaDxqRP9OP2LxFfsi1
         hXdexfnpUt/L8gKARlQ4c7N8hWs33+GxrMLU2jKvufntfSK6VLaywxLo6iXRK9sWaxih
         QLRa5BoWPhikN+Bz9wLjYak4+ejp1ETpQqzBK9Zkf89l5PJDCeAxOWza10SPV6DCw7Tg
         dMMubtblQ9vLsAuEPznzSOdwMCSu08HI0Rl+HXYpUWADZOtXick7tn2n85ubdSTHqil8
         q2TkxSqBKFbB5zZHc7Xldow/tipFVg6JRgeDM9pcTYHN2hjLg3zrC9IuXE5ce7dhpy4L
         fH5w==
X-Forwarded-Encrypted: i=1; AJvYcCWcUnq8L7SfDfupBd1h9ig/hVOr2bhmr5unJ3kIJ0uxEYDPLS81MSsxFbbHFX2IkoXLrmRF4JV1UmB9cKg+@vger.kernel.org, AJvYcCXXZVD0LwwhqUk2LUB1ejRWk9OAYbjVValOOGZmz4mqiaf8d7nBwTR+yYUQFmWsU/XVqowpHaj9@vger.kernel.org
X-Gm-Message-State: AOJu0YzOEY5SkeL4T8Lllg//3MvJv2d+R4DK8iQM34b9te0CifJV0DSE
	t00LLTPwE3hYNBY2Ie1l5oCvma83v1+J6najCx79ZoJWE99jCevy3r232spwSIa9HNQO17B+Trw
	Vh1cQKC2B65v+WFFjJwo/q2MMKu8=
X-Gm-Gg: ASbGncvFrqY5npei2I7MAq/oSEWwwcdyD6cvVLwOfFIrEoShq+HA724Bx9WubWQyh12
	O59dLwHmzKkzGuRINVRdKt+9k/N/ny3/7dUiqMWIcL2ldHeZYx3k6G94WWFU2j9LxtYmXG3wxRL
	ESeumaitxcXh7srwDyed4++XyPUeHcvPIITg==
X-Google-Smtp-Source: AGHT+IFsg3WsedqYYClWbiPfH/kZJGoZhJCSZlGHr/KP3lAIsVoxNjt85IcMoa3Fs4WaZYg3jHMvlVYzOXx7ANmPxAM=
X-Received: by 2002:ad4:5b83:0:b0:6e8:fa7a:14ab with SMTP id
 6a1803df08f44-6f2b2f22f6amr87091256d6.6.1744911556885; Thu, 17 Apr 2025
 10:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415024532.26632-1-songmuchun@bytedance.com> <20250415024532.26632-22-songmuchun@bytedance.com>
In-Reply-To: <20250415024532.26632-22-songmuchun@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 17 Apr 2025 10:39:05 -0700
X-Gm-Features: ATxdqUHfTz5BvLkk64iIoNn6d0Ol7xPi_VzpoY4ezJknMWiDhkMbdgsF-jH6xBs
Message-ID: <CAKEwX=O4MCgM=CrnWWNaan0g1xmAWeFxXM8=OpKuZM4v3ajDFw@mail.gmail.com>
Subject: Re: [PATCH RFC 21/28] mm: zswap: prevent lruvec release in zswap_folio_swapin()
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	david@fromorbit.com, zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, 
	chengming.zhou@linux.dev, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 7:47=E2=80=AFPM Muchun Song <songmuchun@bytedance.c=
om> wrote:
>
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. So an lruvec returned by folio_lruvec() could be
> released without the rcu read lock or a reference to its memory
> cgroup.
>
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the lruvec in zswap_folio_swapin().
>
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

No objections from my end. AFAICT, wrapping this in rcu should not
break things, and we're in the slow path (disk swapping) anyway, so
should not be a problem.

Anyway:
Acked-by: Nhat Pham <nphamcs@gmail.com>

