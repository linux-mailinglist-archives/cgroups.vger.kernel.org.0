Return-Path: <cgroups+bounces-12933-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E4CCF8CA2
	for <lists+cgroups@lfdr.de>; Tue, 06 Jan 2026 15:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB9C2300FE30
	for <lists+cgroups@lfdr.de>; Tue,  6 Jan 2026 14:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D807B296BBF;
	Tue,  6 Jan 2026 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eS+yV8wE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1704B2F85B
	for <cgroups@vger.kernel.org>; Tue,  6 Jan 2026 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767709453; cv=none; b=LQVDAhrW6gg5S/ClPtl31hofO3N1OEFOGUJeqbp1Bz8qh9O84/zCk1YvlwihrtfstCIScwg1jGPaErV5R3/PfwGdQyPao6WjIgYRkLGdiksiS1lk2ANiNg5XyvDzehD3sFzH9neEGxVApl2Z6phrPKh9HFDNWWIZwXZW9PAzEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767709453; c=relaxed/simple;
	bh=nNdVsV52KdhqeNC8yMCpQklGTglYaP6EfhxMiSNTDdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2A3l+4lfJmPKbemghtANzDhypnx/4eGOLgwXVmi+xL95HnraaERtk0bVhitosmkE9CiTvrtWQzhYnns0dQLHej+O+aylBH0pMoFU6QBK0jsLwg2+C/yqoysFVmmdbZFe/OoBIudvrj9YwxqrVmk9nRpmdc7W2TDB8TZQxiciSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eS+yV8wE; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8bb6a27d407so84672985a.0
        for <cgroups@vger.kernel.org>; Tue, 06 Jan 2026 06:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767709451; x=1768314251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKFtmrwYJffjJ5vAfa993qtRrR2MOeXl2weKUw1hfgg=;
        b=eS+yV8wEHN/g/QxuijgGEe/W0Z6wgFpCwu4b8oeJoM8i4HcXsulQEJm3gsmn0asqn5
         aaoY/tRtFDUITVQtOHKCPbTtqcCWhE2TGxwXnknaENOuiITnC+6mbKLWOwVY2au4Glfe
         L2GzpqT9E5pg4yihKw2SKJAyvMMfl8nV66g8O1a/X3NlhUMjpYr90W3ph8jtWSYO1PG/
         WWpFeHrs7UdLkuczPiKinaJWS7HP67EW2AJU0D1l0CcorJ+kZYVgMV64crT8UBcunN1n
         M2USWBDr4IEpf54Miy1qslLj2Z17K8gKukptcPlru54/gQZe4gF3oAHo0y58ZlDty/F7
         b12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767709451; x=1768314251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKFtmrwYJffjJ5vAfa993qtRrR2MOeXl2weKUw1hfgg=;
        b=nrJ0tYKDMvurahkvxW5YXcbrNLl2midenz6bWqAhTN7zjDoM55FTp1TDaznuXv01p0
         guBINr2A/zujaK1dd6lgJdW0CgxmjSBQsLVNvfdf9itF96zup2gJeLNTMK+k7u3FRV1y
         yHMIgrpeO4dc+PcEKDWAsgUWFmyihdlIbZMiYS/gl2WHQU7F744Iy2mW7PzYP0NAfkm0
         mh7wTp/zRLoNNm8MijVx2HC2MlVsJWHJRfANJvRo05LLhDy4MbEQqJ6VsXj9yC4209/t
         xXqcaSmOCoTITYpoqxNrhLjACVBUTRVEz1CEfQ0j+qGPyh7u45xeldmiZWv/pfEXVXb9
         +CwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsr33svzOQjUJVKa0KpY6WJel26dInSYw2TDjsr1mA9h3/qkm4m+ekOdCK+rvOr9f3CPm+5C1E@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhauex5TVT/DbpyTLRj96FnU+h29MYyKBnjgdJ+qnZsF7Uux7
	I9Imms7K6BjdVc1yGM4Zf8a9vyL6Onw1OuFoW+xhMaqMVtEWxvw6eD2piHP25BvpzNHeJS0pT6R
	TPCR3
X-Gm-Gg: AY/fxX6dMO2Q2PaDViNB3NETEqsqInFcO9+CtcxMNYzsMqhFzkgFpLLyviWTgQoEFEK
	pG/v/OvYc/oqqpb0GKQj0dTrQ36z51jwykxY8fxyOg2WRjxs31YkJTxm0iXMK2nbaRlTDsxonzq
	Xvu+9DNEmtsgs0GMrZytlVY1RLFXJf6+B7eZRHfCKtPg/0+01Lwu/TAlVs+w/zsdBjnKrYPlafF
	mn2jOE5C8rA3iFcEYcnXjPdR3H295xtFYEwc4dywqT+k9T82GNDB3Ca1qGd+xzvWxYdDxzgObGO
	IjC3bKTUUc62MgGH2vD4PV9Ni5Tqvl3lZm4odixWJ23D1MXDFhuaTvqMtRW+927oE9kTC5eydDJ
	+j+BYkOo7xyKRpOJGQAGvioEdXMivzgsC3bjxmhPJImxQ6F60xpljhWZj0vSIODndxZj2/oC3mh
	2Zfh/nHOEL8yHE+FrhU0nvsiLy4j6yAEenOEGtOByZiEq4DW1VfFv/Mwca6HRdo50AAlnfRg==
X-Google-Smtp-Source: AGHT+IGMO4IFrkX9A1M1kgyKKyomZ/Tm009TfQhyVAXfXHBjJcxasAIany0LY092XpBTY+2rtwysZA==
X-Received: by 2002:a05:620a:4808:b0:8b2:e3d1:f7e0 with SMTP id af79cd13be357-8c37ead0b5cmr435049585a.0.1767709449546;
        Tue, 06 Jan 2026 06:24:09 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b917dsm178740585a.17.2026.01.06.06.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 06:24:09 -0800 (PST)
Date: Tue, 6 Jan 2026 09:23:34 -0500
From: Gregory Price <gourry@gourry.net>
To: Bing Jiao <bingjiao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, longman@redhat.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com,
	chenridong@huaweicloud.com, yuanchu@google.com, weixugc@google.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v6] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-ID: <aV0a5pYLNV61WJGk@gourry-fedora-PF4VCD3F>
References: <20260105050203.328095-1-bingjiao@google.com>
 <20260106075703.1420072-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106075703.1420072-1-bingjiao@google.com>

On Tue, Jan 06, 2026 at 07:56:54AM +0000, Bing Jiao wrote:
> 
> Bug 1 reproduction:
>   Assume a system with 4 nodes, where nodes 0-1 are top-tier and
>   nodes 2-3 are far-tier memory. All nodes have equal capacity.
> 
>   Test script:
>     echo 1 > /sys/kernel/mm/numa/demotion_enabled
>     mkdir /sys/fs/cgroup/test
>     echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
>     echo "0-2" > /sys/fs/cgroup/test/cpuset.mems
>     echo $$ > /sys/fs/cgroup/test/cgroup.procs
>     swapoff -a
>     # Expectation: Should respect node 0-2 limit.
>     # Observation: Node 3 shows significant allocation (MemFree drops)
>     stress-ng --oomable --vm 1 --vm-bytes 150% --mbind 0,1
> 
> Bug 2 reproduction:
>   Assume a system with 6 nodes, where nodes 0-2 are top-tier,
>   node 3 is a far-tier node, and nodes 4-5 are the farthest-tier nodes.
>   All nodes have equal capacity.
> 
>   Test script:
>     echo 1 > /sys/kernel/mm/numa/demotion_enabled
>     mkdir /sys/fs/cgroup/test
>     echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
>     echo "0-2,4-5" > /sys/fs/cgroup/test/cpuset.mems
>     echo $$ > /sys/fs/cgroup/test/cgroup.procs
>     swapoff -a
>     # Expectation: Pages are demoted to Nodes 4-5
>     # Observation: No pages are demoted before oom.
>     stress-ng --oomable --vm 1 --vm-bytes 150% --mbind 0,1,2
> 
> Fixes: 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Bing Jiao <bingjiao@google.com>

This looks ok now, haven't tested it myself yet, but looks good.

Thank you for the fix.

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory

