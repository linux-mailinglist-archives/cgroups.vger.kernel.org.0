Return-Path: <cgroups+bounces-5353-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C63C9B7FA7
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 17:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178072821BF
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 16:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16451A705C;
	Thu, 31 Oct 2024 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="LX4Vkoml"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E311A38C2
	for <cgroups@vger.kernel.org>; Thu, 31 Oct 2024 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390961; cv=none; b=UFeheb3Emce0EmepeEZfxvhZu0VtlGm8coo5SWUs+D0ZB5yRlKq4z9cDeL81OztCohdPBUfnhq9Ay0LkVXINpCIxQTexY1gIqhoAQO8LAClOgZnrjAS3MgP1bckrrLovFWxxCsyql/E+YBy5brH09wtEb5ZR7+Y6/lHvod3gt+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390961; c=relaxed/simple;
	bh=0MP1EJU+2Idek3AiA2s9w530Zbh818fE5dZH3t/ZqUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwWqAvLw5wkUZ94ksrC/IKdTf4TUaNj2pfkJ/JgOt56+tOWt0AQjAVJEeJe9UVhhiMaTFyXZOcmgCZF34LRth+l/LBbdDIsGvBIlsPZyj8gitUweKQ8FfrSFUPbgrs+OdrheYXRt+HSKY6ivb/OM9uEN25n5SDSfaNy1TklvRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=LX4Vkoml; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b158542592so75877685a.2
        for <cgroups@vger.kernel.org>; Thu, 31 Oct 2024 09:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730390957; x=1730995757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MP1EJU+2Idek3AiA2s9w530Zbh818fE5dZH3t/ZqUU=;
        b=LX4Vkomldp3PlS2TddkaLUebVvBZA+L+UFx9PV32mXmz/a47f44I1SQQz+1gCPqwe4
         2QLoTRQGpsEGbzT1NZAx3prKe9QFG8/ui21iK9E9X/3OTOhurcCIywv/ms5nvusmnfa8
         n5z08vZJCSxSdHje8P0qvmE+X+I7ffrpaR4eryL4i7tf4LaJbv7e+JopUpB4ohUJjhRH
         IKKImh/aL3C9/H6BhNfhHEh4BcquV6jhB7reKqmIzU6PqKneroUhQoGPl/DTiKWa8KGa
         eNVrFse5rGv1pcM22mfHEcb2EpM0nmRy4T3Vs77RDBDBhrqVp3pmtEivSy74EYe+joIS
         jlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730390957; x=1730995757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MP1EJU+2Idek3AiA2s9w530Zbh818fE5dZH3t/ZqUU=;
        b=H6cEUEW6enJrCeyeN09x91csJDzHJkGXKK9isvYl2C1pg1ag3MkzHUGzE4K78T3T2B
         ELa3f+XSdl4qkVrAdNw5MEbAVEzR8w73Exv6qFvUX3zeM05tC4PkJ0KoKVDTk147B12G
         ePb/4qy0xO7azniD4WEQ0YVfwEVXP2t/Vt/EmzFtyp2rSXPCa2WnekkmROLupfu3N/df
         3IpsGzcv08hhWEhasadAa5TLcNenT7X7VOPFTYZchZa9pjmhHB+4gDFw4TYqb9e7a3YN
         GsjC8wZrV82Vgb0nCf70QOAFItFtvbs6TT7HOpV9YNai5OlCLPdHPwNG6J47pVoG8GjR
         S3CA==
X-Forwarded-Encrypted: i=1; AJvYcCXOzPDsuGfXw7OBLD3tcMIp9+V4BdH6Ut8eMeV5PuWL3YvPVF1fsIbLgS7z7JvmOwwbG2KnxbWQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwJc1kMsrTNKA6mCSpispsaEssXcmZkt+doZuJHHyD3aEGZt8u8
	9zskCmxLiRPJdIPIuu6LB61gm49XkdKxdDW9RCPJwxXbimUeT4DRQyolRML/w14=
X-Google-Smtp-Source: AGHT+IEnjifKtBJHoQrQwgD4KdMGYeT83HWXRNYBXlmFZgg8SK4wbJtKEMJF5yR99revJMvIDc8S8g==
X-Received: by 2002:a05:620a:4108:b0:7b1:5089:4867 with SMTP id af79cd13be357-7b2fb9bfe02mr17647685a.62.1730390956566;
        Thu, 31 Oct 2024 09:09:16 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a708c6sm81355185a.91.2024.10.31.09.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:09:15 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:09:11 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, nphamcs@gmail.com,
	shakeel.butt@linux.dev, roman.gushchin@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
	mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-ID: <20241031160911.GB799903@cmpxchg.org>
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
 <ZyIZ_Sq9D_v5v43l@tiehlicka>
 <20241030150102.GA706616@cmpxchg.org>
 <ZyJQaXAZSMKkFVQ2@tiehlicka>
 <20241030183044.GA706387@cmpxchg.org>
 <CAN+CAwM1FJCaGrdBMarD2YthX8jcBEKx9Sd07yj-ZcpDxinURQ@mail.gmail.com>
 <ZyM7_i1HFnFfUmIR@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyM7_i1HFnFfUmIR@tiehlicka>

On Thu, Oct 31, 2024 at 09:12:46AM +0100, Michal Hocko wrote:
> I will leave up to you whether to add above paragraphs but I believe
> they clarify the intention and the implementation.

Both seem reasonable to me to add to the changelog as well.

> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

