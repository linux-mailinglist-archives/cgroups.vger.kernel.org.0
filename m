Return-Path: <cgroups+bounces-5341-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E32E9B6704
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 16:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8189B1C21570
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B241E21313F;
	Wed, 30 Oct 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="gT0SwvO2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766A213120
	for <cgroups@vger.kernel.org>; Wed, 30 Oct 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300937; cv=none; b=JgD4Sjym29d8MJQ3+XLT26m11y575jZmSExlvVAqMz9wNnyMyNQ/+sPlsVbN2YAN0KVaPzSC4jRzubf3pnrxi+LN7BfZI0unbpEM30xbXj7RXFj7q+EICsqoR8829PYmr6Anu3nTn6B97N17TInZKGyb+gkmpsV0EDo0oyAgpgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300937; c=relaxed/simple;
	bh=TYohSDsujhbdiHKtNselbHdfdVVcQ9T6HSEHpSNmHMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODnpW/88x0UD1xWGK1K19/Oq4ysbrnHcPVXUTxn6Jk4LyYACyTr7SYltRHuWnw5lZdQE5E6+JAPz1n+7GXXZ30t9/7PXqPywDjUVU7dgbRLrBw1rRDsNQ0rZ8IIAbpSu5GUCQkgx5qPudO5BsgJFhTUkFKjb6wkDU32rXN7ZLaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=gT0SwvO2; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b1507c42faso80896285a.0
        for <cgroups@vger.kernel.org>; Wed, 30 Oct 2024 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730300934; x=1730905734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A7/6UYbf7ybZ6VNcKsjEex4GMkaYamVw7s21C2iJmhI=;
        b=gT0SwvO2hckBavtjZEg/VUbS7NKpXnpw7v83lx3N74JEE6sQPG+xpb4jI2giLGlVE7
         2gz9ixeM3fabE35uqln+bS2hSZk5KTg4sVqlIKiBHJ+j02TAmNkzNEOMXSSz6HdPd92l
         pFV+mBiQh/sHk4Z2Iwj2ZTMMu24Zz+EOP7AK987nmfe11AUTLHo1vQrXXPNFbfWVuT8v
         d0Wkk547Ou60pDkafNti+gXnrqBn27wZ7MS402/h6gsoZwzbQQIPMEQNjU64iexI7zrs
         p5BH8tg66FDHpTHarB2XTf4BWhQaqWUb4YJizTmxJNn7Tbe1sL8sN15l6X+Jkl1gp2hm
         wuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300934; x=1730905734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7/6UYbf7ybZ6VNcKsjEex4GMkaYamVw7s21C2iJmhI=;
        b=Oeyq1pcpMMOq8UXoHkx4C1r1Wr+9ybZvS5Y1PwEYWv5zdG9NEAt0Xj3N/ZKtsqoXzH
         +bOMmJ7INETgtQaDtSKd251kjLiNbM/pqA+p8U+kK1JNIxBogcGbW3SHIyEkX467YvpP
         FH8cHSHv7ic8V0BNl0OSzLkG+mhNmkWnToL6NS+CFqxLGsb+FS+V24ytOdn2i9d/BJAC
         fBDKQQBNyW6kqoWNG0QtK3CHuXRDWUHOmiscTt5Jk94z7Vh4uEoK6TKlX/0Jv6Iz5UC4
         +Zj2cIsC8SFNLw6d40vPtIRmwbyp7EWJgoIzPm2efp7pVaK7fVVs2NviEH66zNYSS1x3
         RN8w==
X-Forwarded-Encrypted: i=1; AJvYcCX2BA7Kv67VXEty1VBRDhxnyNLIMI2hoGgdS6kAN4IhS2bVfPZUoAnzpaA140QzW0dpJDDnDxhq@vger.kernel.org
X-Gm-Message-State: AOJu0YzJMVFUvXaalObR1hj32Zyom4rcPGrKbKvIZRLgJfqZhNBld1Hy
	sagtYvWNa7pv1ynDvdT24JGcFEw4b460uNYG1TBVW0n3/kURLt00X8dPhtAFoOM=
X-Google-Smtp-Source: AGHT+IEL0dQXvbpBYl4+++/Sj921xMYBN2z8f0z/Fw6yy1eHF/5+LTCuLkRdPXctroNbHp8klXSWdA==
X-Received: by 2002:a05:620a:f07:b0:7b1:4783:aa2 with SMTP id af79cd13be357-7b1a9cc0e7fmr1135432585a.7.1730300933470;
        Wed, 30 Oct 2024 08:08:53 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d2940f7sm519976985a.37.2024.10.30.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:08:52 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:08:51 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: gutierrez.asier@huawei-partners.com
Cc: akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	hocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stepanov.anatoly@huawei.com,
	alexander.kozhevnikov@huawei-partners.com, guohanjun@huawei.com,
	weiyongjun1@huawei.com, wangkefeng.wang@huawei.com,
	judy.chenhui@huawei.com, yusongping@huawei.com,
	artem.kuzin@huawei.com, kang.sun@huawei.com
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
Message-ID: <20241030150851.GB706616@cmpxchg.org>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>

On Wed, Oct 30, 2024 at 04:33:08PM +0800, gutierrez.asier@huawei-partners.com wrote:
> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Currently THP modes are set globally. It can be an overkill if only some
> specific app/set of apps need to get benefits from THP usage. Moreover, various
> apps might need different THP settings. Here we propose a cgroup-based THP
> control mechanism.
> 
> THP interface is added to memory cgroup subsystem. Existing global THP control
> semantics is supported for backward compatibility. When THP modes are set
> globally all the changes are propagated to memory cgroups. However, when a
> particular cgroup changes its THP policy, the global THP policy in sysfs remains
> the same.
> 
> New memcg files are exposed: memory.thp_enabled and memory.thp_defrag, which
> have completely the same format as global THP enabled/defrag.
> 
> Child cgroups inherit THP settings from parent cgroup upon creation. Particular
> cgroup mode changes aren't propagated to child cgroups.

Cgroups are for hierarchical resource distribution. It's tempting to
add parameters you would want for flat collections of processes, but
it gets weird when it comes to inheritance and hiearchical semantics
inside the cgroup tree - like it does here. So this is not a good fit.

On this particular issue, I agree with what Willy and David: let's not
proliferate THP knobs; let's focus on making them truly transparent.

