Return-Path: <cgroups+bounces-7612-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC20A91FC7
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 16:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772EF3B56E0
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 14:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D19F2512FA;
	Thu, 17 Apr 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ZA0N50W3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E486F2512D1
	for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900518; cv=none; b=ijpL4nPvdyTW71/vC758hEFuFAz0wNqSXjNxRI2eEoYAl+fq1FyUck0dQwWP023/1cTmLlmBk6Cq8lznVTeJ1aNB1+HWHXwZ2sy5wzOHl+nKyzRhGveDvC4pLEewdAMHJ/lZvYvYQPIMuW+VPL3pQYhx2oR98ypwUAJ37En8MzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900518; c=relaxed/simple;
	bh=O0K23XSzDEzmMB/Nds0E8PhPNDtKwqVd1INaDJ8nPZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaIzfRlM4Nxk8H6F6PA5gfyFfQvan4N6ogl6jnoxtWBquf+6aTykotubhQIvGW2AWL598Tm6IrijtcS+1sI6MzDsrD9JtVOGPzKJnyJdbouWeG0RnVMQDOX5bu0458edL0r8WU0++FZ0B5xlxManohhRtZcvXrgCb1HeBNnyVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ZA0N50W3; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c58974ed57so75852085a.2
        for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744900513; x=1745505313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g+NB8lZ6NCb5rcy2wsnpxavIgQ1EfGlMDna4xShLC5A=;
        b=ZA0N50W3TtWLJRhkOpNv7HyCD9nMejKoymandPWX8VQePiydScp8JCIhe0PctRVeGc
         FhY5sSfxltQ2eq1lHB5xVG2N0mIl9RMrOgQYXN8KXAkimbI6aDn5zbX2vbbKFV8GXcs9
         ndVr2zeiALLHkvyvGBM/sUtqb86MYeOXvqiV804NtM17mOuV0+qjdxgV9N7GJcCYakM5
         fzwLGVSwHaH/jxTjfq7QKR5RPxZ5++5pI/Nkpgm/T1AsPfxWUPBV9FKyURH1glfxoPHh
         nsietg2aa0dMCg++vj4Nm/r9ChlfsMv8A6OnwBGX5z9owemJVxKzpxKhcczfkh5/z+ho
         I1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744900513; x=1745505313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+NB8lZ6NCb5rcy2wsnpxavIgQ1EfGlMDna4xShLC5A=;
        b=CzNP0OwLPhZHHhBUYpsWzUA2vHVjAEqV/4F2PzlMtOBhbHZhXuS8xmz8fn83xPMdNc
         /q9j1eo9MC0P/X2HQZEhrNl5vT2Ti59k622ZUFscSJa+JxGYN1CkShBYRqDlrXBJpHH3
         JX1zhobDP4rh7IFaiuNvEF1jwkTgq7l6Y5sKedkDKwqXFNR8QhjajJHoRJcN2D89uSSp
         9NSbVNWPlDz/uy9zlNTIIfBK9Ej+FM5LfIUgKyWu+bE4hInOtKIYymOWg9fNEM5LYFcH
         SoQY2idDclIb7Qg3R1A7OOp1mW7wdC0f+sPKGBl2c0X72QlbIL4n0mmRzVDQ05C1HRzm
         jZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKIR6LMwBY+mOF9sTkzmxnXQzBiK7nbGwPR+bA7/Lwk7UDgono4kpHzxuDlFSyB5tGCGdNmMXR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+bOu41ySE/EwUPvVyYBYgBhkJGLLiczZJ3sfySlLXFhkBat0g
	leijpmuDU5DHYI+OwunUbYRpTBYlJQdtqBVYS7KadaRaZIth7q468AVgJchLcbE=
X-Gm-Gg: ASbGncstZSC7p+SXIMD6bYgLTSCM2AGl3kgdaYj02pjJ1G12w3oS6IpviatZF5g0T4H
	nxv+vnlSWoFTts5F7I45fdWmV7CM8vLVwj7rvA6cgWxo/zmdzEtBh6msBh9MKnNdMY0K6MzqwVD
	Jj94fHCfBlRT+FYaFOA3pjXwvrwbBD8JlIaNgdas+HZaoF2ymRgQzlfAo+AD8j7ywkJ6IdP7bw9
	WsSPMfCRAV5znzjyartXuH7qvO+TTJ0GVKm213gclEm26yqwyfIrm1fdqa9RK6dADJ9PQMECZOp
	ntQGAMuODxW5bC+1Qgm5NQylaCNhXsnsxE6OVJI=
X-Google-Smtp-Source: AGHT+IHExexEDk+KWQVgVehLFedYA4ygWhu7sUn8lfwq5cCL9JrL5njO5WYNRXhHDbtsDX5FvbrU3Q==
X-Received: by 2002:a05:620a:2955:b0:7c5:5768:409f with SMTP id af79cd13be357-7c919083be9mr889987585a.57.1744900513667;
        Thu, 17 Apr 2025 07:35:13 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8943834sm1182663285a.22.2025.04.17.07.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:35:12 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:35:12 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	david@fromorbit.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com
Subject: Re: [PATCH RFC 01/28] mm: memcontrol: remove dead code of checking
 parent memory cgroup
Message-ID: <20250417143512.GD780688@cmpxchg.org>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-2-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024532.26632-2-songmuchun@bytedance.com>

On Tue, Apr 15, 2025 at 10:45:05AM +0800, Muchun Song wrote:
> Since the no-hierarchy mode has been deprecated after the commit:
> 
>   commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical mode").
> 
> As a result, parent_mem_cgroup() will not return NULL except when passing
> the root memcg, and the root memcg cannot be offline. Hence, it's safe to
> remove the check on the returned value of parent_mem_cgroup(). Remove the
> corresponding dead code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

