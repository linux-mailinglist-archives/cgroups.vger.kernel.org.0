Return-Path: <cgroups+bounces-12511-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C37FCCC3D9
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 15:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 994D3309EC50
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBA32FF151;
	Thu, 18 Dec 2025 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="rqBlpTi6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9312DFF28
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066844; cv=none; b=BKLkZllnflnIhhSuwgden4U5w3ivvecPF0gS6KJMdiKqep2WDI0+KKr4lBdneQGg4mvAYdrEI+hBJ3zAvaZ8YLIb02wyDPrHWAl+zTJb4K07OU96c3veyu7EBBYUxXKkrg+3WPB73MTy4qARssoLp+1miEKzWnYIL5iyaDXxJ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066844; c=relaxed/simple;
	bh=cyRkwkcif+K+CsZdzk1eOhaZBfXb1enbIIPQ/KkKAqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLOw0n7jLA98ld3lN6O2lVPVCExn4wNL6alApk6xtyIsGGgSK5BI6UMTozMwjT/DnnVzpdZu7mBlle6fP4/C4Jc9/HqXnkPkXnv2lHmJZWUlZvv7Fe3JlfWUz+cp9wkoPLoVPl0pfP4bhev8fe82/KSCWI0nPwShDMiBvhJYoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=rqBlpTi6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4f1b147eaa9so4860271cf.3
        for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 06:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766066842; x=1766671642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3Yk/IRp6Zp7DBqOloMlN8iycWBryyxsjXHj1unL15o=;
        b=rqBlpTi6gWCjzaKJVc1hWZc7WLEa3cozNhHEue9Yu9Knzgo5QWKNtlj+J1G0R6laoT
         NRnbuwoWUDDqZLz0TwNBWADsVTu88KNRXaleUHO1U37zZCZjCyiuhYfCzM9mReHCpYqJ
         qFHbXU/nRKDdY/HCgzwJamyNDTxTfGBOjdrlUjOXauJNLeFLGvYMKw6qqCAw02mB3LB8
         qAqnA6seun9tZXPLPnt5iy16PszzMHjdRD67J3rbPYONuhQELRNJSiU2GBVoDSeSRE+A
         0EQO1KFhS5c7/HOL3oXGoQ8nqPoR/hHQ7kHwnYVBZCzZ2IICBxVVHb9SfzjLO2YMOcm+
         PnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766066842; x=1766671642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3Yk/IRp6Zp7DBqOloMlN8iycWBryyxsjXHj1unL15o=;
        b=kSTjzYHOND/qoGVAeIxexNOmqqu1blIX01CVH1pg/PIHC9sSNIIBLwQwFpG4afJW2M
         5ZilTmGNguU82c+N5vUTOgQwhoRPxkfX/LTpp6tlnvX1JhL8mWjxevYPDZMCR90pK6Cb
         utBJ+Di2oiMX6JpMp9ZUQVG/zZzpG82Nujl5uZKPVWiHPj68ZPkQrwQQdUHE2liwRdav
         /tbrIJ6ewWOgFkGZQIn9ov8pAC73vcgE80iS666UQsqPVfnX2ZnS7ImTHXwzb/CiBqtC
         wBfD72sLkYa+L/w2bRev4HjD+gA39IYKsijHjkwGx0wfSXqw6ZR4S2TiA175lbegmx9U
         4Nnw==
X-Forwarded-Encrypted: i=1; AJvYcCXisuisssvfWOAlHYTd2ACgKpF6W3ic6Iferl2wEdUyY0UjVgaVprF36jqlWX30pYSDZlyGVVqr@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLS1McUtsvFlk6KGviHBx/tdpNjIidlgthR/Z1vosPyGMomZZ
	YtKrltxGSUz10ONWLTOkfG9s9CcSrQC95bLNYR6c8LwkzRU+VMlHT4HaYosYpX5Ed+c=
X-Gm-Gg: AY/fxX6rehjw1yzhXLIWuvQue6qaCm1j4HaEezPiTxxedH/DWrzpiQVUCkNGhyK70eQ
	xiiSP+Cby39q9kycyik5TklvJ9O7J+n9/yy3dQIwL5ca4dG9qHfbC3RcdrLRLSeuEbA8PUmd6Vg
	xXziXCQEVgB9/oAiBBdmv20jc5qrJR9mX194xPyCVZx2FxJnaat1hT8SZ+JzH6VCiXo1YT+TPFQ
	Xtptjy3lC5ZmY5kTsA4ZKFU4IHlHhxwN2YckD+qx5PXb4W7Hk4KrZ2c6U6OP3PV4ylcxOK3BUO7
	Ef2E57ozXC/v0HJ/s6EI+ChZTlxOWyZ5z42+ZnNAfy06oNJa+c6tcGu/nuI0xD+LzIMiExYbtyC
	rW8W63wrNpyYUJqBGoZMdUAC9Qzd77VWJ8u9tGipF5Zh+jZ5aLjF2r65EnFDtpO9FWC6cG77cCD
	f81H+NEOPzhw==
X-Google-Smtp-Source: AGHT+IE662eUXVCxzedx+R7CP6z1+RBNmbFjm/pj4Sw6Hxp9pdtcZdIHfK528VnH65h3sOZ1zf3hCg==
X-Received: by 2002:a05:622a:1650:b0:4f1:c66a:f36d with SMTP id d75a77b69052e-4f1d059c8cemr279117411cf.42.1766066841750;
        Thu, 18 Dec 2025 06:07:21 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f35fca94e9sm15687941cf.11.2025.12.18.06.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 06:07:21 -0800 (PST)
Date: Thu, 18 Dec 2025 09:07:20 -0500
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
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 28/28] mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru
 maintenance helpers
Message-ID: <aUQKmOvR1uVfXqgc@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <a3ee89c663fd0f5b0f0c5579a1a2a39a0563727d.1765956026.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3ee89c663fd0f5b0f0c5579a1a2a39a0563727d.1765956026.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:52PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> We must ensure the folio is deleted from or added to the correct lruvec
> list. So, add VM_WARN_ON_ONCE_FOLIO() to catch invalid users. The
> VM_BUG_ON_PAGE() in move_pages_to_lru() can be removed as
> add_page_to_lru_list() will perform the necessary check.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

