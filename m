Return-Path: <cgroups+bounces-7027-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 689F2A5E7F0
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 00:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9721783CE
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 23:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1200F1EF38B;
	Wed, 12 Mar 2025 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="2hkJOiBV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547B91F30AD
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820481; cv=none; b=oQC/pOuQTG9zpcmYZ8pBy7KHkn3k/Kn+ZTItTSiRBUFptWdv06HFtIHDEXsg20TJAzd678yzRvf+RguMr0i9z5z4k0L99ZDwXxVpaK9yNSF80IIhSWr0c924EEyrxaQYY0fn+bIVJQY3ol+v9vFPjlBBx9ZJoUNmF97cWrAwDjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820481; c=relaxed/simple;
	bh=+rpDxaQgm+wsQPbws3qQsNkRIKl9zmIeGuw5sA2yj/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZZTgUh+Sbs3nDe6iqpiOS7F8bTgk1KxYvs3BS2Vny+ebZAtTD+7FroKnEhVCPBTodUG7YBfVSigKiNmwPDy1HL49Y84w0bSn/Tnrpe5kIZT7s6XDwygZe7I7/RpETfKSIEsfgFrdFcDdpC4lxRAd8+Hipuw0XZuCDPGdytbHqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=2hkJOiBV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476b4c9faa2so3372971cf.3
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741820477; x=1742425277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/k48zVdw7SyhnQrDrLHbVl8Rl30ZSbI9RE/c9vyrahs=;
        b=2hkJOiBVlTuzioFSMUGCYbWS+O6F1B7rf0+f6sYBepplXynldKA3fFJOWqQt81oigd
         flBiqZwPzS041J1bpVf8P9kK19965RkR8DTNwVCFiOUZZ+Y9ixFHDADose27NRDJMpsd
         3Ogl8Za04+PyAm99F9sm6HjkKgABbMkCcITg0UPVilciKK+b/EEvBlrRtQT0yg5v7rBt
         lE84hwQ7TlryVQnt8krrVkz65ncsx6xxfWxco71ZgkYZiEEOKNi1CAREzuRIXcJQID2z
         OY6IdymGd/YWFwwIl+VNw22SNPeNOpn6Pn+uqvRoVfytiLYVa+qtLmXGtu7Brk8RzXsZ
         BC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741820477; x=1742425277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k48zVdw7SyhnQrDrLHbVl8Rl30ZSbI9RE/c9vyrahs=;
        b=sfKRgp6a/04+Mbdztb4P6uy5vsManz8PhBhDnj2k5KXvBdjTLcO12390GRsEZBqH2S
         muJr/HOGkGFlwhv7/PhQIvgl7qIsesbiHFG97Oe9pvDwoulgIS6liZd5oork3aRmP1rq
         oTCNUjUcya09BOgxRZmizSfnhRZ0yVq9YsuC7hGuFpYqHE9Pmc/743JRkrk8/9LghDv4
         yHJeJ8m/nD9m9Bpq0qmI/aYO08c3jD1+GZtmnRccPD1AG+X5mmWjLvpWmIdlGcODa/0B
         QnjQDVxNXbdBW06ESJlXk1TEmhfKxJyWlN5/vcuiO2VRIoFcC5iG+ZqTW+EH7EyqfdhM
         K7iw==
X-Forwarded-Encrypted: i=1; AJvYcCUBAroVPaOw3/TuVUFvXj1CU4yWyRicHZlj9IuliydWbHkg3YDLLfU3CAshREdzkVdyW3Fw4gfv@vger.kernel.org
X-Gm-Message-State: AOJu0YytzeRXY0RQSZdyszzlcpnAaNrHlmCmBnE/lZvc0tl1i3T1z5pN
	5uNPpgwwYj62q2Iqw7g0OtzOJJgsI+SIdVrLHNU0P/UsW1WvZ/ZUmrpZhJq0mwA=
X-Gm-Gg: ASbGncvGb9T8d7ypVeLZJSa4EWXwwH2Xf64Vdng/qrD4lMuN2RBqdweN+cF1Mc0cLg9
	DvLFUEwW19xQ06dSPvqUkxYNFSrmIWrLEVaHfZLPsPZjoKawC3gj+tGhCubhPJdcRbVbVEiy6P1
	qp7pHuLl4ecsxsqdwaK5es2Xo10pJToY7knvyglt9FAxsYLeqtWd7iVBccgLOCrxxVYz3GshhSS
	oippJVqY29m0ke+FMSppaygEDStvuWnb77Wl7QMAe9XbD0Wf57oEoQVxw+SHtaRokG13o15x8AJ
	UmvvQ0c8xu0UEZCnFqxQqd6zKUR9y+3Y25Ar4L8fa4I=
X-Google-Smtp-Source: AGHT+IHh1pCjpeXCj9O057it0duPj9RnmfTnaglKfOGbIcKnK2/5+F6nwuoQMbtwb+1X3EUnHJ6fdQ==
X-Received: by 2002:ac8:7fd6:0:b0:476:9001:7898 with SMTP id d75a77b69052e-47690017ef3mr156653221cf.25.1741820477055;
        Wed, 12 Mar 2025 16:01:17 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb7f4f08sm822891cf.56.2025.03.12.16.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:01:15 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:01:14 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: move do_memsw_account() to CONFIG_MEMCG_V1
Message-ID: <20250312230114.GA1247787@cmpxchg.org>
References: <20250312222552.3284173-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312222552.3284173-1-shakeel.butt@linux.dev>

On Wed, Mar 12, 2025 at 03:25:52PM -0700, Shakeel Butt wrote:
> The do_memsw_account() is used to enable or disable legacy memory+swap
> accounting in memory cgroup. However with disabled CONFIG_MEMCG_V1, we
> don't need to keep checking it. So, let's always return false for
> !CONFIG_MEMCG_V1 configs.
> 
> Before the patch:
> 
> $ size mm/memcontrol.o
>    text    data     bss     dec     hex filename
>   49928   10736    4172   64836    fd44 mm/memcontrol.o
> 
> After the patch:
> 
> $ size mm/memcontrol.o
>    text    data     bss     dec     hex filename
>   49430   10480    4172   64082    fa52 mm/memcontrol.o
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Nice. It being a jump label avoids the branch, but it's still
unnecessary text and therefor i$ burden on fairly hot paths.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

