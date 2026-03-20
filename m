Return-Path: <cgroups+bounces-14935-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDoZCIjBvGnM2gIAu9opvQ
	(envelope-from <cgroups+bounces-14935-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 04:39:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8172D59C9
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 04:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E19BE305A6F8
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 03:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAA12D8DDF;
	Fri, 20 Mar 2026 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDkuQyc5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706A2C027E
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 03:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773977987; cv=none; b=o7cxCNcUSldBD6glC3VcLJ9n/LbrFs41PDS6qSv8ju2SYFwFMWObHqZ1gj2cpNptvYgXN2PBVGwJQPY1E+eq6E9n1pyJDrHJXqhcOO5DvPHpkA4Z0t5xhaeOwaizs7yHmwXiGhl+4AszX5yCv097cADPM9FfexedCTE0wC55+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773977987; c=relaxed/simple;
	bh=P/YXk8VBR+UZp/m/PSuTOoFARBhxT4ayCpwB7zK7i+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcGEFKqh8mdZhhujcldUwHVLGmXBhAX2WUI/raanFq5Jvjd73dIWUPtk10ZgA0J2xMR1NGxkXb9CzN+EZ+yxUF8lcBDD71jtphhO0mwSKwXIRKXBPTVi1ovAV11CtkkFcIw+uv22BmcmJ6WcASyJdtMLH0wgzQ6aZozvPa8bMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HDkuQyc5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aeab6ff148so33695ad.1
        for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 20:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773977986; x=1774582786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/YXk8VBR+UZp/m/PSuTOoFARBhxT4ayCpwB7zK7i+8=;
        b=HDkuQyc5wdWOrTTiAF0r9uAO359HQMWWYIm33aXXfxUY9cwsIjUXjtW72USk73aCUI
         +EMCuE+37tDq8q5a03AtBR5XGrUesWsubS5x/Y7o/3RgQ4dcL6wJs7O8bBjcNRwcPkYL
         ipSPuyC9GHVqUG5Ro936VcWb8dDmP0Hxfdqpl/zquh62Fe5UgBmepRdbZMzXad9OU45R
         ILoaZU7/nxdMeRcTStOSoTOVhBxXo/IYY7Iq0BC0JPCZKoY3QKZ50EAfX1CBIZFg8SaN
         iWRdOLDXYRoVCJNd7fyQC5x3d5OyVgDOcYUrPnSDk8IPQccAz9oz+QHdGp6mkWEbsgcY
         BtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773977986; x=1774582786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/YXk8VBR+UZp/m/PSuTOoFARBhxT4ayCpwB7zK7i+8=;
        b=OJZYbhQqK66faDtiMwTGkfAtTIcU/wbfewWWO8JyW1xCdWeLb4T/+ITHIlbRR4gtFN
         zrucH72j6e82cxvnJrt+vWgHM27L0YZ57DDMLOqzJO1TJNEcNqMY2DjEPA58lWSebZ5J
         P82F/9NuYCaX+jBud9f2/7AjJLjlTxpXP8lkCCcviaX6NSLW+lDAPvoElIyKWBlD/+V1
         +4mCKyXqB73MkGObnWyxxUJpVFnE3OJOGOlqvOQfBHKFVJVvMnwBskqWhlDqv+TUG3Du
         jEHyfQI/1ZXvJjbolubOup6m28b+W3o6FqXOhjFwtNjNOc34oJKMzxyRoXm4y3MAXS1S
         cY3A==
X-Forwarded-Encrypted: i=1; AJvYcCUW7K0uXpzHoa2U3UgBmLulnKic6Yf3ntBr3SCUdPEhxn7afwLVBwG/nbD4iC08X8l4mH7EtHYI@vger.kernel.org
X-Gm-Message-State: AOJu0YwJV0EmT32MXhn+0C6PvVmjnY4lBdDSPYVGIh8DAItMYbakl5sd
	CxeJs32eIemTa7jNs27ydkCWAuT6yGDiH39pJ2u7p7Cz5lS/b5GHHrjz53DKoPRiAQ==
X-Gm-Gg: ATEYQzyfrmr5hH5D7A7vQH6kS65K19c+vS2ysrn4n4eo6ViCilt+0+sqKgZGD3zHE7y
	c3fM/+iKHnsCcPGcUFCwQuQDW7l4GK4I94FOMH4g1IyoSYR3NcJ+uVqHBtLnh0f4pYliF6sKaV8
	runCI5zobbI2a9EpHDM0EXe3S3tk6k89Z459UJf5NkEImBFMzHpuEfzfr9PpP7GPH879bKVA1Y2
	pQ/t3Xy49rBBBDsmcOfjFSdtdNbT6tqO0mu5QEuW3rYq3hK47DuX0nrKnqeMJn2zVVNGuod4rDa
	axeoBfiyDxBGbRdL8EHuK1qnN4BeK/qBV9xlDaRunKvGjD80Q4QYYCJjfTZRpGmJeEKvcwoRgSl
	lxLT3b+A9byQRz0QCmHVUMePJX/91d3cMcbo1rdoTxzSbj6xzh+SfbWcGOK7MQkTVm2EJbvCd+7
	+CeiFXt+j5XCGvwO661N1X1J/R2Rvee24Xf9EH/QfqvA0ftb2jAcYSRrbR6J1l+o1unWVsvRZco
	1/R
X-Received: by 2002:a17:902:f652:b0:297:f2a0:e564 with SMTP id d9443c01a7336-2b0836e92e2mr1101815ad.11.1773977985452;
        Thu, 19 Mar 2026 20:39:45 -0700 (PDT)
Received: from google.com (206.238.125.34.bc.googleusercontent.com. [34.125.238.206])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd412b73bsm502858a91.15.2026.03.19.20.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 20:39:44 -0700 (PDT)
Date: Fri, 20 Mar 2026 03:39:40 +0000
From: Bing Jiao <bingjiao@google.com>
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org,
	bhe@redhat.com, cgroups@vger.kernel.org, chrisl@kernel.org,
	david@kernel.org, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, ljs@kernel.org, muchun.song@linux.dev,
	nphamcs@gmail.com, rientjes@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com,
	weixugc@google.com, yosry@kernel.org, youngjun.park@lge.com,
	yuanchu@google.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v3] mm/memcontrol: fix reclaim_options leak in
 try_charge_memcg()
Message-ID: <abzBfHzRndwjrGQY@google.com>
References: <20260318215629.2849052-1-bingjiao@google.com>
 <20260318221957.2979346-1-bingjiao@google.com>
 <abvB65BYCUDT9JF1@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abvB65BYCUDT9JF1@tiehlicka>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,kernel.org,redhat.com,vger.kernel.org,cmpxchg.org,gmail.com,tencent.com,kvack.org,linux.dev,huaweicloud.com,lge.com,bytedance.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-14935-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bingjiao@google.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.945];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7A8172D59C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:29:15AM +0100, Michal Hocko wrote:
> On Wed 18-03-26 22:19:46, Bing Jiao wrote:
> > In try_charge_memcg(), the 'reclaim_options' variable is initialized
> > once at the start of the function. However, the function contains a
> > retry loop. If reclaim_options were modified during an iteration
> > (e.g., by encountering a memsw limit), the modified state would
> > persist into subsequent retries.
> >
> > This leads to incorrect reclaim behavior. Specifically,
> > MEMCG_RECLAIM_MAY_SWAP is cleared when the combined memcg->memsw limit
> > is reached. After reclaimation attemps, a subsequent retry may
> > successfully charge memcg->memsw but fail on the memcg->memory charge.
> > In this case, swapping should be permitted, but the carried-over state
> > prevents it.
>
> Have you noticed this happening in practice or is this based on the code
> reading?

Hi, Michal, thanks for the ack.

This issue was identified during code reading, when I was analyzing
the memsw limit behavior in try_charge_memcg(); specifically how
retries are handled when demotion is disabled (the demotion patch
itself was dropped).

Best,
Bing

