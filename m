Return-Path: <cgroups+bounces-3527-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA499267D3
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 20:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2362896F6
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E855187543;
	Wed,  3 Jul 2024 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEFY+Q7Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A3185E53;
	Wed,  3 Jul 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030175; cv=none; b=YezI/6fri6BzL5qb6Zm4m7lmn2HkvrJ47WEKh3I27XYdaYBJ43AMxx6WD0QcDQ/Qp8pA8+HRMiWNYlSjqtEyhZqem7V8M/L/0IUxVcS3OyLbRGAutIvswWjepXTWiqRwpkPb6r7sySpZcqseldfFC4/XwGA2JCnu9fa6WS62zU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030175; c=relaxed/simple;
	bh=pE8UojUxvsUTrTbmPwYotN6I2N/PVqI/hdhpFcSnIGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PErxefdbp/UrKvadEdnuie6olvHn8ftorRjBch1dwwQvmc5jmtspRJkirgaee3wSEk1nX+WbJW4fmsPH923T7WKveuLCViOQB1li4pm0TcbXeSU8EaCvgMt9CbVqxIkIwZoSju5zEYYSql48bIx9w+xBcLWLcHEVJH7vNq3Flss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEFY+Q7Y; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f480624d0dso42634325ad.1;
        Wed, 03 Jul 2024 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720030173; x=1720634973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nERZSIG+9P3/XY2VuM/TfBeyxDC9IgQmuXZYoF/vBHM=;
        b=dEFY+Q7YJYwzNzsehwrCt68WCWN97wlq5rP1vHgxPh0wc4XjkgtD3OHQ61m3mUUJ8B
         CoXTDOuFVa80LrPExLOHz0V7TvA7l9oLcdIuIctLATbAezTHZlYtwXPOu3zieEnlFd2V
         tbJ86Eo1GhBkxf06oCK9Lo0N5YYTCqkonU4u/6DIVjF7Y32rZf0flog5+Kc3Yho2pAZ5
         lhZItsopaJtnC76pvnGzz/u3IJ7iT54/DVT2clIT5TsxbGlKt6F2prEP2oHf0ZBSKAaM
         yVT/KWQd5zMC+ic59jewHNIx/fMfYZ1WJ9cV+vWG/Zf7mMa/ElEEehb6z+PJFKiNAVy/
         1QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030173; x=1720634973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nERZSIG+9P3/XY2VuM/TfBeyxDC9IgQmuXZYoF/vBHM=;
        b=jImcl3ia10XacbY+L0Z3lda3E+OD+yu/amGZdrc3mCPFaCbQ4lAhbDphxmMY5F/F+/
         tSbkelxbiZX3aUPFAJ8KD4G0/4Qf7vLE+SF+grZVnTRUTL51rUKPNrQXlsSUeGc3gjr+
         jPgqdbzNKJyX2d3uD2YDqhhSQwl/JxvkGDuhCWcs4NxkRmo2SGh4LgAOlX9zUyxQw2GQ
         tEh/PnoFSROfSP6Vk3diQxL/XnQy7d9eaq3Q+PXPkEL9YvdvcZuEgBkK66CuLxgCrlST
         B/5LVeGbMUJmL2LyUqpY3O5n3E0kmo7OcC8SwrpXT56pUNaX38yPZ5tOYjS8BLpVJH10
         FLdw==
X-Forwarded-Encrypted: i=1; AJvYcCXVISFpYg6SRNIVHLEW3CUTBhiIZNwVGOcEya7SxQ3C/gpWPKjHsI/POvUCqaWNOz4YSAmvkrTLdXSIZPO3xBEkDcGe1jYeyM1p7fSNlDUP9bZ5U/fMOP7XxvDhQT8etRJoVUMS2WUsD0gGU5COwI4vPwM8V96OvtN9WEkaDUP80w==
X-Gm-Message-State: AOJu0Yw56GGuWHpzsAhHZPGnPY4iQFBns99YvNk1Kr/GDNS1Q6tlDb2F
	4PY95l5NM3iQ1KH8QzTzDhxDq/Um1SoqUoDd8A0vz1vFMx5I67pQonoWow==
X-Google-Smtp-Source: AGHT+IFzD6hT7SV8vSVqYV+sEfsYjrm7wSKeq/WyV1dy7QOHkZbDHHqPDSfQZRQyXeV6I8nkqNohWw==
X-Received: by 2002:a17:902:f545:b0:1fb:1e2d:9d23 with SMTP id d9443c01a7336-1fb1e2d9dd5mr17287625ad.30.1720030172928;
        Wed, 03 Jul 2024 11:09:32 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb1bb5488dsm15160695ad.136.2024.07.03.11.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:09:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Jul 2024 08:09:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
	kamalesh.babulal@oracle.com, haitao.huang@linux.intel.com,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 -next] cgroup/misc: Introduce misc.peak
Message-ID: <ZoWT21ElQDnnUtYL@slm.duckdns.org>
References: <20240703003646.2762150-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703003646.2762150-1-xiujianfeng@huawei.com>

On Wed, Jul 03, 2024 at 12:36:46AM +0000, Xiu Jianfeng wrote:
> Introduce misc.peak to record the historical maximum usage of the
> resource, as in some scenarios the value of misc.max could be
> adjusted based on the peak usage of the resource.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.11.

Thanks.

-- 
tejun

