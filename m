Return-Path: <cgroups+bounces-1126-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF3782B53B
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 20:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70DB51F25776
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 19:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC6055C31;
	Thu, 11 Jan 2024 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="iWYDUfYn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D115E9B
	for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4279b73b5feso36198531cf.3
        for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 11:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1705001701; x=1705606501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLoXRmz2jBVaQs8TX4snXcztzXaT+m5gtz1vw2oxIw0=;
        b=iWYDUfYnXIuC8PfBkQWyPVUiy2cu9JTJ+OR/df8SZoXasPU3MKPsFIm19Ovpz+UhwJ
         hwQN9IsQL65LHg5nxVAnvSchR+z558t491IR3SLPD1Z0ZBw5HtQU5Hky33WKRiqPv4Qt
         dQ0ohJvXZzRDwieEJE4P5eWdYmfjIWJGHACXzXRobNDCCFUdTr38z0Xyhs2KFLis26Sx
         q2j0px1MB6AT84I7I74u3Jox/0/X18iR9yUghLdG4F6tA9gFdrC/G+NcHwDaWnoUye7f
         /duwc1p0SdqTQ084hqoiUVTz4D6QzVzLJHYiJKX1V59lw2U8W+yo5sNxUqbNlZWXaCNh
         UMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705001701; x=1705606501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLoXRmz2jBVaQs8TX4snXcztzXaT+m5gtz1vw2oxIw0=;
        b=LGXnGNbszicDFt/5+PttQSJASvVjdmp4x6ANZg6KBhTRwgEG6ICsHD+3Ch5AUv68eR
         EPXuuYn9psrrKJy4+BKHY/0T6ZddEnNGemEXpGi/jD/jDHwEWsMAQlKvPpaNift1L+Nj
         puDKzansWGSaa+SlCD9w/vDFP4ohqd2vd7CNB/ctRbQx6xDzKJnH5f4+5fHuReRcekks
         0ebceGCjobVijcElaUY0pKGEmxfcpRlEVp5RHwZE7C5QXFl4AH7DBNQANs+aP78jw1Ra
         nD3KJHr/Jbng3+BUr//YMtrcOrBfvtFROlFBB6q+orxFhitDWYxyoGKW7qDTCM4y+n/g
         58uA==
X-Gm-Message-State: AOJu0YxyHLDadNIJFtsKyaos6+VmpUcz753zcUvPB5qDNjaP8kRUcN+s
	3+MmsCNGtLJrOqGnFiIU7gXcwbIEQbr5WQ==
X-Google-Smtp-Source: AGHT+IESiYzdGU2J3mDzGCqM8eHwuxSUQZhi4LkEdizH4HGTmPHVoeaPSKuBs0rCmbRj/VfaedM62A==
X-Received: by 2002:a05:622a:180b:b0:425:89a1:b2ec with SMTP id t11-20020a05622a180b00b0042589a1b2ecmr320301qtc.100.1705001700666;
        Thu, 11 Jan 2024 11:35:00 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ks8-20020ac86208000000b00427f2baf6e8sm670093qtb.93.2024.01.11.11.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:35:00 -0800 (PST)
Date: Thu, 11 Jan 2024 14:34:59 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/4] memcg: Use a folio in get_mctgt_type
Message-ID: <20240111193459.GB424308@cmpxchg.org>
References: <20240111181219.3462852-1-willy@infradead.org>
 <20240111181219.3462852-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111181219.3462852-4-willy@infradead.org>

On Thu, Jan 11, 2024 at 06:12:18PM +0000, Matthew Wilcox (Oracle) wrote:
> Replace seven calls to compound_head() with one.  We still use the
> page as page_mapped() is different from folio_mapped().

Only seven, eh? :) For the 4 patches:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks

