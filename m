Return-Path: <cgroups+bounces-2156-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0C888B116
	for <lists+cgroups@lfdr.de>; Mon, 25 Mar 2024 21:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECF51FA5A9D
	for <lists+cgroups@lfdr.de>; Mon, 25 Mar 2024 20:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105E15B5BB;
	Mon, 25 Mar 2024 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMA28uNT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61196548EF
	for <cgroups@vger.kernel.org>; Mon, 25 Mar 2024 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397553; cv=none; b=hnyhjd9JILil5985Kyg/00ZwBx8a5r19tvRgM8sUuAzI0O9XLWgE6ShvHaeGR5nRMlLgP6KVoZV59PWpB7yYvNLAXFGY7v0S8V9K+prRwqWikteT2cxmb7fw/cneSvcz7ZEKhqPJJPoHTCthXvttBnW47aDsWmQcekyG7rRTggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397553; c=relaxed/simple;
	bh=xGkVOf7VlRD212T25BHmWwvSkrd8iiq/Wfio6c8QpCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1kYvCIALL3p5THWWh5lV4P/8Q1LBVOZqrIsfy8ZVKgood68sl51lnbsXOk0bMAbByW/CEqKVdMhNUJRQzzfiTPeDjN/tzzysVn832HJXbkzd45ko53dfofRs9OmTU8Af7d6cXXOMO4Glz1R1r8oCokmUzmZ746Z+xhLmlHKyzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMA28uNT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e04ac200a6so33310955ad.1
        for <cgroups@vger.kernel.org>; Mon, 25 Mar 2024 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711397551; x=1712002351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHKGKzuDNhWxNthcx7U0hCQOrZ7eNRUkc4ROmxaemWI=;
        b=bMA28uNT7s2UrVW0PJQMQ6cO4LubIc6PyukcKS4CtvwD7KZmPEUJETBzg3yIrUojWY
         uSjKawziIG99a75TndIQ8JQ10AjhbxxMPgdjVJx9XZAUR5hE77Hdkqed7g2pt53zP1vS
         kumTYb5mDptj8lm3eIsY5jZY6kxzfP/btUBd+agwWhauI5Z9o0QeUiXu/iDeZxj9gcrE
         B60qsY+T8kJ426/b+eQJxVDT3JzczS8a9c+YJ0wPDDNBQZV5cpPMsceWhdj7D5snqFdg
         Z+eTHODmvaI0ZOXdzOs6anxpGOYeC4HtwiaPepMumBkukFqHzpsVp67zF/bk8705ZBUb
         I2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711397551; x=1712002351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHKGKzuDNhWxNthcx7U0hCQOrZ7eNRUkc4ROmxaemWI=;
        b=RD5UznmNyG28QgbD+NaVWoHFmiRG+JkOr6Sgqdc4E2RiRQfbqU4JySQLQNCDtwvM/j
         QHjQNVsDBn/qqCb12itHtE6TaFdLu3F+ouMI/Cq52JxCc/0SugRl0hrAFNUuY4TDkG3e
         /1odXeE3qgSCpWigH/3lj6HN7JhzV4P69mi7upjfyC08PAT9+yZk0LBpqG/XA0IPd6kF
         sxjUOgjVM66/pV+5HGYVVrMV5PPGhtcfH26U3Ur8CtyHiB/SA5xGXM3Wp2U0wgHMCgxA
         jWgwNkGnGcgsDKCeXXzxiErInrEPdzhQmZwjITMUmDqx7JjzqL4KChJAiVtvBvQCxave
         j9cw==
X-Gm-Message-State: AOJu0Yzo8lgFQjrfLFl/oLDM1U0wjBbUYnO9aXSDq5hDEpKIgn9AWpZn
	5uz3Heh9oRiFQy40DPUm+ObXCdANUxONRLZzO26idkpse+B2X7O8
X-Google-Smtp-Source: AGHT+IHCtvp8mn9K5usVZbALLpvZBiSqDjzOwZGyWQQoy653Bh9aQjEsZFakwiW5QVysfB8ZamRLsw==
X-Received: by 2002:a17:902:e74a:b0:1e0:c571:d648 with SMTP id p10-20020a170902e74a00b001e0c571d648mr4133082plf.9.1711397550692;
        Mon, 25 Mar 2024 13:12:30 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id jf6-20020a170903268600b001e088a9e2bcsm5098190plb.292.2024.03.25.13.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:12:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 25 Mar 2024 10:12:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Petr Malat <oss@malat.biz>
Cc: cgroups@vger.kernel.org, longman@redhat.com
Subject: Re: [PATCH] cgroup/cpuset: Make cpuset.cpus.effective independent of
 cpuset.cpus
Message-ID: <ZgHarUDknkJyidia@slm.duckdns.org>
References: <Zfynj56eDdCSdIxv@ntb.petris.klfree.czf>
 <20240321213945.1117641-1-oss@malat.biz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321213945.1117641-1-oss@malat.biz>

On Thu, Mar 21, 2024 at 10:39:45PM +0100, Petr Malat wrote:
> Requiring cpuset.cpus.effective to be a subset of cpuset.cpus makes it
> hard to use as one is forced to configure cpuset.cpus of current and all
> ancestor cgroups, which requires a knowledge about all other units
> sharing the same cgroup subtree. Also, it doesn't allow using empty
> cpuset.cpus.
> 
> Do not require cpuset.cpus.effective to be a subset of cpuset.cpus and
> create remote cgroup only if cpuset.cpus is empty, to make it easier for
> the user to control which cgroup is being created.
> 
> Signed-off-by: Petr Malat <oss@malat.biz>

Waiman, what do you think?

Thanks.

-- 
tejun

