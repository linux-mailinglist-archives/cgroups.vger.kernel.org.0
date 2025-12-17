Return-Path: <cgroups+bounces-12457-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E94EDCC9B5B
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 23:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30880303EF71
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D904A311596;
	Wed, 17 Dec 2025 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="OKs9N8BA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D76F29D27E
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010475; cv=none; b=kdqNSZ7It8tY70hZk2qr0sMiOC3hPdfyuaUojIS+1B3ZlqXu1imWwrfInsOtRevnH6xk+gcztEKT60Bwa1j3gCG3LPz0XNTwBg+Dwcm/+lVjkxFa8mnPXTMXRgHm5tGnmP6jiNfp82TYi+AxCHdmDXHlOzvzAGczWhCLrDyV2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010475; c=relaxed/simple;
	bh=nCJw+FDBojpSGJbtZqEv7h20G1emc5hP9coRva32nnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhxjYLN4chtKOTYgdsWPPzr2xhWKm8110uKjgi+X+va8guK8wH64nSbJ1ioPV8bBZBzt3dtVmDnCKmjRB/IgJwUsCn7kaPEH6snH3i/Q8Sfb5jia7WbaoED/ypQC4Sduq3mAw5L1c7GKbA2OdvLOfZVyp8amHJZJg+Lt6fGfY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=OKs9N8BA; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b5ed9e7500so2784385a.0
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 14:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766010473; x=1766615273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aP2xNPBMnMxTzb75tZtSoPHwVxBgrcZpOLdt0vBQOLc=;
        b=OKs9N8BAXdKkIdKQSTgKlFqV/tI8HpcZjnrwetL3maKssVYpmolQWr8f819LJSQnGR
         d+1Syz6Nq4Qn7yk6Xo4kW6a14fKc7e9feus/4zw9Qw6HUM3wzLw3NgIRucoFzb77m3Qz
         ILEl224G3e7nYPxppk4kFddhH7Pa6ouQB6fk1WIvBjVQlwZIrnQUt75ywpQ0ZlVXuJru
         Birgi8qgas2rMpMfMOfFMOxX/mSu7AhyJ1gecgH2X0jDpiqCzF7398ObZIgiABfJ6byO
         I+aCd7V69Gqxs5eHLRZmdflEOsqe/heiu1gWPma9jeiz6f4bFsSAGC6Hb18qbsO8vldo
         5Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766010473; x=1766615273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aP2xNPBMnMxTzb75tZtSoPHwVxBgrcZpOLdt0vBQOLc=;
        b=G72nvItFqD5Huwyrdy0gMb9HMXD/eg9MVMnTJy/qLyCTawxuJXLrHQesgwPKOR7cIc
         kPbwUED1FLy3pO/A3fGCFw1hoZYZ9J/C4G2OzEGNpoToKCjponAi9jByTietDKH7pmPP
         EaupDFNvCBtL2HbJwkz7+fRO0oDjoCuAmZYnuOv6MuzkRKqRk3H2nPS5dMm1U2yZAXi6
         BNeeyA02BEW663nC09NfBF+zqFSfiHVn9f/R4WpnXL3Gk8yNJXKl0bnz3Upn2Fq7o4SR
         Vz6dhPXYyWhK3jj+4CTrrjUDe0ARkYzXBXZAgFcu1xxDZG0LrxjTzYbRpJF0HedEeL9S
         7gCw==
X-Forwarded-Encrypted: i=1; AJvYcCX/6pVnNI4hYwS31E0vHEz/fW5qEhdorz06EdPsP9PNTBjJ1HUrLfpc30sF2vUtrOVAas3Y64xR@vger.kernel.org
X-Gm-Message-State: AOJu0YxOHmerH/q5riZxSJXu26eFduEu24Y++he9/JpCB4acjKQp47gz
	Wq3kdGaczFEqmAj85qxDde5awuy45h2uvgGRy66Wir5Lo4r6M1uSaabBrNlKjbyq5+I=
X-Gm-Gg: AY/fxX78uTrh26gz7VA6rJ1YLn0yHAJjQZSgJ6bwwdwcN8Jh5zVva1GlCAM9w9BlADe
	f/n1BH2/4TnVzPWJgdqcHRSm3a/GIo2KLqlTKl6AMPSDwuWwbY7GbQ5DAKXEeNZMEh5HwlQcjVM
	eg3L/6+T9teRVemULLQ1QsJuidmB592X1LO+3vNSuC1g9POPhSIrQDdBpPO61OYXH5ftdh77F+m
	8c5cHQNZayxDTyGm3kdkDsxAgFw3P5esn12tmf8d/axxj4dJPju2PXrRTxRWchRYoZfFLeN+HlA
	JZw528FYWrYVr6MF//BhJ8zHCm7oPAP6QsJktbwaeM2O4lMdq8yUYaqeBn1UhTMYKtLD9e02Zkd
	DfO5mVtwhF7eNK8lTr0TMEHn6VPBDJROOT0SPG2eLtg7N8zl/TLb7UFt86TrjbBcwJjrGeV5ryf
	OjsGVixd48wA/igmZd/aty
X-Google-Smtp-Source: AGHT+IEfFl1nZHnH205UDOdO/2YcSf3f7mGkXXRNlXeIJKOKcFcgdrIIyXU3DOKqRW+7y+wbgq8+DQ==
X-Received: by 2002:a05:620a:1789:b0:89f:52d:8560 with SMTP id af79cd13be357-8bb3a248d15mr2896187485a.47.1766010472929;
        Wed, 17 Dec 2025 14:27:52 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8beeb6fa2f9sm39210285a.24.2025.12.17.14.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:27:52 -0800 (PST)
Date: Wed, 17 Dec 2025 17:27:51 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 18/28] mm: zswap: prevent memory cgroup release in
 zswap_compress()
Message-ID: <aUMuZxMRSMIc3EKx@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <cbd77b6cb5273b75fb2d853f368bcb099f52869e.1765956026.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbd77b6cb5273b75fb2d853f368bcb099f52869e.1765956026.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:42PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding memory
> cgroup. To ensure safety, it will only be appropriate to hold the rcu read
> lock or acquire a reference to the memory cgroup returned by
> folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard against
> the release of the memory cgroup in zswap_compress().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

