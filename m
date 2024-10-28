Return-Path: <cgroups+bounces-5294-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD119B323F
	for <lists+cgroups@lfdr.de>; Mon, 28 Oct 2024 14:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E32F28194C
	for <lists+cgroups@lfdr.de>; Mon, 28 Oct 2024 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFA01DC1A5;
	Mon, 28 Oct 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="VqeQRIaf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1829D1D2B1B
	for <cgroups@vger.kernel.org>; Mon, 28 Oct 2024 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123703; cv=none; b=AGmHlRG4+l/VXOXQLFimKbnZtn/B0xEwjPDVJnVRLghrMtYquz5WCrlixSjIcuA/DspRgiDlJ3nI2v7M1hRe4k6oRndhWv4FVCsSoKdMux6+hJ6JcVUnAnEmKtJWl2dN47inI3oUqlDgeHaJkF7Gu8ctml+8DFgxOwly7xjxd/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123703; c=relaxed/simple;
	bh=qL02jNM6QmkzSbt2ixQNsK3JzmKMePb8iL5x5oQAhv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTxAW9JndtOCZpOlRHxpVcu7PfxsCqscOF65SdGW72B6TSSS/OCIhw2YNl7bRk4e3wuL0motaJFHhFhpsJK68PIDavFJyXCX72NurE/2E0wjDEOWvsS70I2WlUQkWbw7EE6LRSqEoh/SdI/RZsvdQCiwoVuvKghYr+YDdV0eGe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=VqeQRIaf; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460dce6fff9so32723311cf.1
        for <cgroups@vger.kernel.org>; Mon, 28 Oct 2024 06:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730123700; x=1730728500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XdtW+9c27laTcra3rAzShsDaFJHdIeIenw692lRPhns=;
        b=VqeQRIaffq4EvXZks2ytrJaf97/g6QwUiOjEuIvJEErEjcr+rE1wAihHKj42i7IXjT
         cKN35Rto5W06O00htQJTcgOsq9vMjlcigDhgnNNWtzGtHkbGT01/tLMZH9JECoGBZv1z
         0+oGJ1iGBQ5TPbGFAymYT2qXBB6TqpPMLyAjYhoohvpDH/9FeVGy8vFjk3Wfw8/82Bx+
         8JLXg7gm2atdlb7qDjGFPrIk+l8melaxCAJJBQ1JXdhfTqUbx91ck4ZacHSNQy5tPkXf
         nW4b3rDG6NBFFJl9mZXejGtuVOmHuwluhoRkT7Vrtup4t6rGvUXM8w9eQOaeHFe3Y2Hl
         /YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123700; x=1730728500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdtW+9c27laTcra3rAzShsDaFJHdIeIenw692lRPhns=;
        b=Serek4uL/4n11QtC/zjHT8ck/SFsPMgAYT5a/kXFnAFiwjtwe9LcGfA5OyIbqS83CO
         rA0mBs63fupNXnckpj8TzooaQBSccZRmxYvfTwJ3yNJZYIYwGXm+6j96oXJQxqV1ZeyW
         ssa5shEMDX7uUTe4PdC+J900dvlz6gi0ziqzgqDFWsdlxPkKQV5sO2kv2th4/15NAiS9
         oQm3Xw2Sa0M1eg+cfdFbcUfl9lSiYLCfEoEY+BgUaNqvLUC6oLXXT+cfYOHwXgFAPfA9
         jA07xYAeqTU3f0wlHLlC3jcKcvWglUvhVYk8vihTQKR1+XsP2ri8MPtIBE6aOrTVkLt/
         Jlxw==
X-Forwarded-Encrypted: i=1; AJvYcCXufo99j3JZ6xx/ySoi7XtP2td8FQJVXIoO7CoqLI+NvwJjBTMa9vQA0A+vF3LmJgvoCaMc2DrT@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgPsRKTVEDcZAUBZOwtun1Y+IwiBCg8lp6rdq61bQO3Xq2tRJ
	10Q8xPai+h1bokkAByGEW0Z76fhHe42qHyWTQY/yCLg+15/6pW//wkQA+jbsFeY=
X-Google-Smtp-Source: AGHT+IGbX3q3h5Rj5AEwNGKx4zq0zvgm4jApVpmYWXOD0GBg1g5E9PSQsj0MoWVji8f6oOFjZAjUlA==
X-Received: by 2002:a05:622a:341:b0:460:adce:bfe9 with SMTP id d75a77b69052e-4613bfdc4b6mr141463971cf.4.1730123699937;
        Mon, 28 Oct 2024 06:54:59 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613214d426sm34785721cf.36.2024.10.28.06.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:54:59 -0700 (PDT)
Date: Mon, 28 Oct 2024 09:54:58 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v1 2/6] memcg-v1: remove charge move code
Message-ID: <20241028135458.GB10985@cmpxchg.org>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-3-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-3-shakeel.butt@linux.dev>

On Thu, Oct 24, 2024 at 06:22:59PM -0700, Shakeel Butt wrote:
> The memcg-v1 charge move feature has been deprecated completely and
> let's remove the relevant code as well.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

