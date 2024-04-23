Return-Path: <cgroups+bounces-2679-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8F58AF735
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 21:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9001C210E8
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 19:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEAF1411C7;
	Tue, 23 Apr 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APMj3veZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E085613FD9E;
	Tue, 23 Apr 2024 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900096; cv=none; b=UfIaPZ2GUfw8bBORo3uPUgoqA3etGU4uTfyD1r4WCl7TZp/5TcbzymGtcuQNNb+PA/ACrZSdxb5E2VTPL2rJ79u6jRM5/QqWpWOP5FfC1BHv51HCYtW23qbkmt/sVaSBsoaYUpsVVYt5wa+uSfnF75gYzb/1ItPyu1/PPOEkZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900096; c=relaxed/simple;
	bh=gw/VwvioNTKZR+naghmiVpj6yya48Ee1rO9e5dkmQ4s=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 References:In-Reply-To; b=IzWzpmSoymmNA4qDBQ91YqgiIRYEEEuWtBscnl1tb75OxhGPcYXNOcvrMGIL5bdvUX3Pa9JS2cBHtfQGwMfSjvbWnftb01pqKgOINl+nyYaKlMrjKIlS9vzCDN6NSmzcK9odXkyKgbx/9sIyOXXxcys+/JZCcG/wP/BgBLeloQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APMj3veZ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so80590651fa.2;
        Tue, 23 Apr 2024 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713900093; x=1714504893; darn=vger.kernel.org;
        h=in-reply-to:content-language:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uytzz43yUsjk+isNouu+mHdPNDNcP9ct/lukuCRqH5g=;
        b=APMj3veZC4k7ml5O7muM4YUowjhiaaUo7d+sm1qduT6DeJ1r6Wv6LiAipWx5cl+t3o
         y0HqKM2hOD2XNyoiqzAE8AUUzF/v2yn11HQH4HGG7uLvQHFJ3Y9anXCxpjjAHP5l3agq
         wtQjYQxYs/PqrqFQk3WOi5GeSFRkdP6zVFo7N6xpm9M4NEm6r2nBnAbfGCrrmUZDAK/0
         lLvHO0eODzhzDmz2K5ozKFPXh/XA9Z83GE7n0DyZ9MSFlvzy3QYypkqZVenQxJEhtD9M
         PyJaI3sV9mWGa57zIi7AsHyLUMBZiIxCnrPRoMQD9osZSpjSnLRrcbepqdwrjrzXZupN
         qb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713900093; x=1714504893;
        h=in-reply-to:content-language:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uytzz43yUsjk+isNouu+mHdPNDNcP9ct/lukuCRqH5g=;
        b=sXSwse+HrP/4JS/A1Yddue8ReEYfcn24Dc64dwdgOR4KAvWESc6Xwi4WP1Gc1kEEig
         QnMo7HiwtE/MubWhNk4dZsdjWjmbuDVNMZjQhyRHDLFGyjFKPUO2dM9AW5+70VVGzySY
         tPvKNFLF2JPG68Ol6EKLXMZi96q0vld6bDCWHKNGt+5+2h4ia5MtZ0kzM44rc7zxFvbW
         3YVbJV6luMHIxBvidw2l5k6Q4h7uaigFL2AKHlYh0OAV55sy/w6SZMVIns2tSbGfJEzT
         EOFvvsNV2yUmJnXIwnenlQm4TxnZ0W8uS2pnsCJ1euesRwK8RSW9QEP7+upq3xWQfgPZ
         H7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Glk+1MFZ5hYY2lRWTo0QmZiJGCltygWrNofKZKSt9RY10H6ngT+kQlzw70prI1s0i1CwNYxOuD2rKAK9b0+lT4wUWpKAsETkJ3t4
X-Gm-Message-State: AOJu0Yzkemq5s0sQ57VpAuy5xd+zpnzMZkbZfrTJHJhWATdNamwqDl0t
	EPMU4UbttJIIvu0sVXFk4ZKzo+US9N5sckGjVYkw9UeEfZ0gnz3a
X-Google-Smtp-Source: AGHT+IFz4AzxPklA70G1nLeBxBmJQsPtxb8zJqw+DO8P+ZaP/0G2X3gxEL1lALD6775DYyOhkJjgWg==
X-Received: by 2002:a2e:920f:0:b0:2d4:9201:d505 with SMTP id k15-20020a2e920f000000b002d49201d505mr93690ljg.51.1713900092558;
        Tue, 23 Apr 2024 12:21:32 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1204:59b2:75a3:6a31:61d8? (soda.int.kasm.eu. [2001:678:a5c:1204:59b2:75a3:6a31:61d8])
        by smtp.gmail.com with ESMTPSA id l3-20020a2e9083000000b002da6fb7ce36sm1804426ljg.135.2024.04.23.12.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 12:21:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------i0xLLoC3g7fNCBA4IsfbGtmy"
Message-ID: <f2edf788-6ff3-43b1-9445-ac237e7910ac@gmail.com>
Date: Tue, 23 Apr 2024 21:21:31 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Klara Modin <klarasmodin@gmail.com>
Subject: Re: [PATCH -next] cgroup/cpuset: Statically initialize more members
 of top_cpuset
To: Xiu Jianfeng <xiujianfeng@huawei.com>, longman@redhat.com,
 lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240420094616.1028540-1-xiujianfeng@huawei.com>
Content-Language: en-US, sv-SE
In-Reply-To: <20240420094616.1028540-1-xiujianfeng@huawei.com>

This is a multi-part message in MIME format.
--------------i0xLLoC3g7fNCBA4IsfbGtmy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024-04-20 11:46, Xiu Jianfeng wrote:
> Initializing top_cpuset.relax_domain_level and setting
> CS_SCHED_LOAD_BALANCE to top_cpuset.flags in cpuset_init() could be
> completed at the time of top_cpuset definition by compiler.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d8d3439eda4e..e70008a1d86a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -369,8 +369,9 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
>   
>   static struct cpuset top_cpuset = {
>   	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
> -		  (1 << CS_MEM_EXCLUSIVE)),
> +		  (1 << CS_MEM_EXCLUSIVE) | (1 < CS_SCHED_LOAD_BALANCE)),

You dropped a '<' for the bitwise shift, this causes bad cpu utilization 
for me.

>   	.partition_root_state = PRS_ROOT,
> +	.relax_domain_level = -1,
>   	.remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
>   };
>   
> @@ -4309,8 +4310,6 @@ int __init cpuset_init(void)
>   	nodes_setall(top_cpuset.effective_mems);
>   
>   	fmeter_init(&top_cpuset.fmeter);
> -	set_bit(CS_SCHED_LOAD_BALANCE, &top_cpuset.flags);
> -	top_cpuset.relax_domain_level = -1;
>   	INIT_LIST_HEAD(&remote_children);
>   
>   	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));

Kind regards,
Klara Modin
--------------i0xLLoC3g7fNCBA4IsfbGtmy
Content-Type: text/plain; charset=UTF-8; name="bisect-bad-cpu-util"
Content-Disposition: attachment; filename="bisect-bad-cpu-util"
Content-Transfer-Encoding: base64

IyBiYWQ6IFthNTk2NjhhOTM5N2U3MjQ1YjI2ZTliZTg1ZDIzZjI0MmZmNzU3YWU4XSBBZGQg
bGludXgtbmV4dCBzcGVjaWZpYyBmaWxlcyBmb3IgMjAyNDA0MjMKZ2l0IGJpc2VjdCBzdGFy
dCAnbmV4dC9tYXN0ZXInCiMgc3RhdHVzOiB3YWl0aW5nIGZvciBnb29kIGNvbW1pdChzKSwg
YmFkIGNvbW1pdCBrbm93bgojIGdvb2Q6IFthMmM2M2EzZjNkNjg3YWM0ZjYzYmY0ZmZhMDRk
NzQ1OGEyZGIzNTBiXSBNZXJnZSB0YWcgJ2JjYWNoZWZzLTIwMjQtMDQtMjInIG9mIGh0dHBz
Oi8vZXZpbHBpZXBpcmF0ZS5vcmcvZ2l0L2JjYWNoZWZzCmdpdCBiaXNlY3QgZ29vZCBhMmM2
M2EzZjNkNjg3YWM0ZjYzYmY0ZmZhMDRkNzQ1OGEyZGIzNTBiCiMgZ29vZDogWzgxMTVkZjRk
ZDk0Zjk4YjM1ODg4ZTZlOTE2ODExMTg2NDkyOTgxNDJdIE1lcmdlIGJyYW5jaCAnbWFzdGVy
JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQva2xh
c3NlcnQvaXBzZWMtbmV4dC5naXQKZ2l0IGJpc2VjdCBnb29kIDgxMTVkZjRkZDk0Zjk4YjM1
ODg4ZTZlOTE2ODExMTg2NDkyOTgxNDIKIyBnb29kOiBbM2FkMjBjZGRhZjI5NjNhY2Q0NTRk
Njk1NGY2NWFiYmQwMmY3NmI4ZV0gTWVyZ2UgYnJhbmNoICdmb3ItbmV4dCcgb2YgZ2l0Oi8v
Z2l0Lmtlcm5lbC5kay9saW51eC1ibG9jay5naXQKZ2l0IGJpc2VjdCBnb29kIDNhZDIwY2Rk
YWYyOTYzYWNkNDU0ZDY5NTRmNjVhYmJkMDJmNzZiOGUKIyBnb29kOiBbYWRlYzExNjQzMTE0
OTYwYWQ0NTdkMDg5MGViYzIzN2NmZjRlNDg1Zl0gTWVyZ2UgYnJhbmNoICd0dHktbmV4dCcg
b2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2dyZWdr
aC90dHkuZ2l0CmdpdCBiaXNlY3QgZ29vZCBhZGVjMTE2NDMxMTQ5NjBhZDQ1N2QwODkwZWJj
MjM3Y2ZmNGU0ODVmCiMgYmFkOiBbM2Q5ODYyY2NmYjg1N2FhNTQ1ODNmMWYxNzk1M2Q4N2Ew
MTNjZDk3Nl0gTWVyZ2UgYnJhbmNoICduZXh0JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc2h1YWgvbGludXgta3NlbGZ0ZXN0LmdpdApnaXQg
YmlzZWN0IGJhZCAzZDk4NjJjY2ZiODU3YWE1NDU4M2YxZjE3OTUzZDg3YTAxM2NkOTc2CiMg
YmFkOiBbMTIxNDE4NjY1YjA3YWZjYmNmZjNlMTU0ZjI5N2MyZjNiZGNmNTYwOF0gTWVyZ2Ug
YnJhbmNoICdncGlvL2Zvci1uZXh0JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvYnJnbC9saW51eC5naXQKZ2l0IGJpc2VjdCBiYWQgMTIxNDE4
NjY1YjA3YWZjYmNmZjNlMTU0ZjI5N2MyZjNiZGNmNTYwOAojIGdvb2Q6IFsyNGRkZWUwZmY4
YzM0MjU2ODkxMzIzYzkyYmVlYWEzYmQ1NWEwZDMwXSBNZXJnZSB0YWcgJ3N0YWJsZS92ZHVz
ZS12aXJ0aW8tbmV0JyBpbnRvIHZob3N0CmdpdCBiaXNlY3QgZ29vZCAyNGRkZWUwZmY4YzM0
MjU2ODkxMzIzYzkyYmVlYWEzYmQ1NWEwZDMwCiMgZ29vZDogW2Y5MjE0MWUxOGM4YjQ2NjAy
N2UyMjZmMzM4OGRlMTViMDU5YjZmNjVdIE1lcmdlIHBhdGNoIHNlcmllcyAiY29udmVydCBT
Q1NJIHRvIGF0b21pYyBxdWV1ZSBsaW1pdHMsIHBhcnQgMSAodjMpIgpnaXQgYmlzZWN0IGdv
b2QgZjkyMTQxZTE4YzhiNDY2MDI3ZTIyNmYzMzg4ZGUxNWIwNTliNmY2NQojIGdvb2Q6IFs4
ZDFlODRhYjAxNzZjMmQyYjQ5ZmQ3NDFkNjYwOWEwMjFlY2MxZDAxXSBncGlvOiByZWdtYXA6
IFVzZSAtRU5PVFNVUFAgY29uc2lzdGVudGx5CmdpdCBiaXNlY3QgZ29vZCA4ZDFlODRhYjAx
NzZjMmQyYjQ5ZmQ3NDFkNjYwOWEwMjFlY2MxZDAxCiMgZ29vZDogW2E2Yjk3NGI0MGY5NDJi
M2U1MTEyNGRlNTg4MzgzMDA5ZjZhNDJkMmRdIGRyaXZlcnM6IHJlbW90ZXByb2M6IHhsbng6
IEFkZCBWZXJzYWwgYW5kIFZlcnNhbC1ORVQgc3VwcG9ydApnaXQgYmlzZWN0IGdvb2QgYTZi
OTc0YjQwZjk0MmIzZTUxMTI0ZGU1ODgzODMwMDlmNmE0MmQyZAojIGdvb2Q6IFtlOTlmY2Fj
MDU1YjMzMjUyODNkNmM1YzYxYTExNzY1MWZiMTQ3Njg2XSBNZXJnZSBicmFuY2hlcyAncnBy
b2MtbmV4dCcgYW5kICdycG1zZy1uZXh0JyBpbnRvIGZvci1uZXh0CmdpdCBiaXNlY3QgZ29v
ZCBlOTlmY2FjMDU1YjMzMjUyODNkNmM1YzYxYTExNzY1MWZiMTQ3Njg2CiMgYmFkOiBbNmMw
N2IwMGJhMWZmNDhmYTliZTBkOGUwODRhMDUwM2ZiOTNkNGI2NF0gTWVyZ2UgYnJhbmNoICds
aW51eC1uZXh0JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvbXN0L3Zob3N0LmdpdApnaXQgYmlzZWN0IGJhZCA2YzA3YjAwYmExZmY0OGZhOWJl
MGQ4ZTA4NGEwNTAzZmI5M2Q0YjY0CiMgYmFkOiBbZDA4MmFlZTEzM2JmODJiZjUyZmZiYmI5
MzM1NWNmZjZjNDczNjg2Ml0gTWVyZ2UgYnJhbmNoICdmb3ItbmV4dCcgb2YgZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21rcC9zY3NpLmdpdApnaXQg
YmlzZWN0IGJhZCBkMDgyYWVlMTMzYmY4MmJmNTJmZmJiYjkzMzU1Y2ZmNmM0NzM2ODYyCiMg
Z29vZDogWzFhNjViMDA4NDc2OGEwMTA2YmE2ZjM3NTQxZjcyMTZjNDQ3ZTQ5YjJdIE1lcmdl
IGJyYW5jaCAndG9ncmVnJyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvamljMjMvaWlvLmdpdApnaXQgYmlzZWN0IGdvb2QgMWE2NWIwMDg0NzY4
YTAxMDZiYTZmMzc1NDFmNzIxNmM0NDdlNDliMgojIGdvb2Q6IFswNDI1Y2Y1MGY1OTU3ZTU0
ODUyZWE4Zjc3YmFhZGFlNzgyM2MwMjY2XSBNZXJnZSBicmFuY2ggJ3NwbWktbmV4dCcgb2Yg
Z2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Nib3lkL3Nw
bWkuZ2l0CmdpdCBiaXNlY3QgZ29vZCAwNDI1Y2Y1MGY1OTU3ZTU0ODUyZWE4Zjc3YmFhZGFl
NzgyM2MwMjY2CiMgZ29vZDogWzFjOWUxNmI3MzE2NmJjYzg5YjNkNjQ2NzRiNjA5NDNlYzYx
NDJjM2VdIHN0YWdpbmc6IHZjMDRfc2VydmljZXM6IHZjaGlxX2FybTogU3BsaXQgZHJpdmVy
IHN0YXRpYyBhbmQgcnVudGltZSBkYXRhCmdpdCBiaXNlY3QgZ29vZCAxYzllMTZiNzMxNjZi
Y2M4OWIzZDY0Njc0YjYwOTQzZWM2MTQyYzNlCiMgZ29vZDogWzk4ZjIyMzNhNWMyMGNhNTY3
YjJkYjExNDcyNzhmZDExMDY4MWI5ZWRdIGRtYWVuZ2luZTogcGwwOHg6IFVzZSBrY2FsbG9j
KCkgaW5zdGVhZCBvZiBremFsbG9jKCkKZ2l0IGJpc2VjdCBnb29kIDk4ZjIyMzNhNWMyMGNh
NTY3YjJkYjExNDcyNzhmZDExMDY4MWI5ZWQKIyBiYWQ6IFs4OTk2ZjkzZmMzODgwZDAwMGEw
YTBjYjQwYzcyNGQ1ODMwZTE0MGZkXSBjZ3JvdXAvY3B1c2V0OiBTdGF0aWNhbGx5IGluaXRp
YWxpemUgbW9yZSBtZW1iZXJzIG9mIHRvcF9jcHVzZXQKZ2l0IGJpc2VjdCBiYWQgODk5NmY5
M2ZjMzg4MGQwMDBhMGEwY2I0MGM3MjRkNTgzMGUxNDBmZAojIGdvb2Q6IFtmYzI5ZTA0YWUx
YWQ0Yzk5NDIyYzBiOGFlNGI0M2NmZTk5YzcwNDI5XSBjZ3JvdXAvcnN0YXQ6IGFkZCBjZ3Jv
dXBfcnN0YXRfbG9jayBoZWxwZXJzIGFuZCB0cmFjZXBvaW50cwpnaXQgYmlzZWN0IGdvb2Qg
ZmMyOWUwNGFlMWFkNGM5OTQyMmMwYjhhZTRiNDNjZmU5OWM3MDQyOQojIGdvb2Q6IFsxNWEw
YjVmZTFhZDZmYmVjZmE2NTE3NzUwNzE4MDg5ZTEyZWU4MzQ0XSBjZ3JvdXA6IGRvbid0IGNh
bGwgY2dyb3VwMV9waWRsaXN0X2Rlc3Ryb3lfYWxsKCkgZm9yIHYyCmdpdCBiaXNlY3QgZ29v
ZCAxNWEwYjVmZTFhZDZmYmVjZmE2NTE3NzUwNzE4MDg5ZTEyZWU4MzQ0CiMgZ29vZDogW2Y3
MWJmYmUxZTI4MWE3MDdlNzc2NmViMGE1OWJhMDU2ZGMwZjI5ZjldIGNncm91cCwgbGVnYWN5
X2ZyZWV6ZXI6IHVwZGF0ZSBjb21tZW50IGZvciBmcmVlemVyX2Nzc19vZmZsaW5lKCkKZ2l0
IGJpc2VjdCBnb29kIGY3MWJmYmUxZTI4MWE3MDdlNzc2NmViMGE1OWJhMDU2ZGMwZjI5ZjkK
IyBnb29kOiBbMTlmYzhhODk2NTY1ZWNlYmIzOTUxNjY0ZmQwZWVhYjBhODAzMTRhMV0gY2dy
b3VwOiBBdm9pZCB1bm5lY2Vzc2FyeSBsb29waW5nIGluIGNncm91cF9ub192MSgpCmdpdCBi
aXNlY3QgZ29vZCAxOWZjOGE4OTY1NjVlY2ViYjM5NTE2NjRmZDBlZWFiMGE4MDMxNGExCiMg
Zmlyc3QgYmFkIGNvbW1pdDogWzg5OTZmOTNmYzM4ODBkMDAwYTBhMGNiNDBjNzI0ZDU4MzBl
MTQwZmRdIGNncm91cC9jcHVzZXQ6IFN0YXRpY2FsbHkgaW5pdGlhbGl6ZSBtb3JlIG1lbWJl
cnMgb2YgdG9wX2NwdXNldAo=
--------------i0xLLoC3g7fNCBA4IsfbGtmy
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-cgroup-cpuset-fix-bitwise-shift-in-top_cpuset-initia.patch"
Content-Disposition: attachment;
 filename*0="0001-cgroup-cpuset-fix-bitwise-shift-in-top_cpuset-initia.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkZmM5YjEwNGJiNjJhYzdkMDU0NmJlNDQ1Y2U2YWRkOWU2ZDhjMmZlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLbGFyYSBNb2RpbiA8a2xhcmFzbW9kaW5AZ21haWwu
Y29tPgpEYXRlOiBUdWUsIDIzIEFwciAyMDI0IDIxOjAwOjU2ICswMjAwClN1YmplY3Q6IFtQ
QVRDSF0gY2dyb3VwL2NwdXNldDogZml4IGJpdHdpc2Ugc2hpZnQgaW4gdG9wX2NwdXNldCBp
bml0aWFsaXphdGlvbgoKRml4ZXM6IDg5OTZmOTNmYzM4OCAoImNncm91cC9jcHVzZXQ6IFN0
YXRpY2FsbHkgaW5pdGlhbGl6ZSBtb3JlIG1lbWJlcnMgb2YgdG9wX2NwdXNldCIpClNpZ25l
ZC1vZmYtYnk6IEtsYXJhIE1vZGluIDxrbGFyYXNtb2RpbkBnbWFpbC5jb20+Ci0tLQoga2Vy
bmVsL2Nncm91cC9jcHVzZXQuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC9jZ3JvdXAvY3B1c2V0
LmMgYi9rZXJuZWwvY2dyb3VwL2NwdXNldC5jCmluZGV4IGU3MDAwOGExZDg2YS4uNjJkNjQ5
ZDAyZjExIDEwMDY0NAotLS0gYS9rZXJuZWwvY2dyb3VwL2NwdXNldC5jCisrKyBiL2tlcm5l
bC9jZ3JvdXAvY3B1c2V0LmMKQEAgLTM2OSw3ICszNjksNyBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgbm90aWZ5X3BhcnRpdGlvbl9jaGFuZ2Uoc3RydWN0IGNwdXNldCAqY3MsIGludCBvbGRf
cHJzKQogCiBzdGF0aWMgc3RydWN0IGNwdXNldCB0b3BfY3B1c2V0ID0gewogCS5mbGFncyA9
ICgoMSA8PCBDU19PTkxJTkUpIHwgKDEgPDwgQ1NfQ1BVX0VYQ0xVU0lWRSkgfAotCQkgICgx
IDw8IENTX01FTV9FWENMVVNJVkUpIHwgKDEgPCBDU19TQ0hFRF9MT0FEX0JBTEFOQ0UpKSwK
KwkJICAoMSA8PCBDU19NRU1fRVhDTFVTSVZFKSB8ICgxIDw8IENTX1NDSEVEX0xPQURfQkFM
QU5DRSkpLAogCS5wYXJ0aXRpb25fcm9vdF9zdGF0ZSA9IFBSU19ST09ULAogCS5yZWxheF9k
b21haW5fbGV2ZWwgPSAtMSwKIAkucmVtb3RlX3NpYmxpbmcgPSBMSVNUX0hFQURfSU5JVCh0
b3BfY3B1c2V0LnJlbW90ZV9zaWJsaW5nKSwKLS0gCjIuNDQuMAoK

--------------i0xLLoC3g7fNCBA4IsfbGtmy--

