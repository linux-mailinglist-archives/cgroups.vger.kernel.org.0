Return-Path: <cgroups+bounces-15678-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCgnFoGC/Wk7fQAAu9opvQ
	(envelope-from <cgroups+bounces-15678-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 08:28:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4574F2764
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 08:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48B273027321
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 06:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34AF37A4AF;
	Fri,  8 May 2026 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap4kO7gm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18929374E7F
	for <cgroups@vger.kernel.org>; Fri,  8 May 2026 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221688; cv=none; b=A8gQLJyT3dBVmKzRLUkAoJEIbBaIp84WBbJet+x54CJqmXmSfbjax212sk0SM8vvA3wrj7u1ZdgVpFFzrhB8mNj1ATcpQKyATgagh7Y6RozNYjbM8fS8KEZoYU8/neqn/v6uGA/Wxmop8MO5oeUhLaeDO4CX3b1bxTmeh9ISW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221688; c=relaxed/simple;
	bh=yhmlbFiEgxAAdHgzy7VMbB8ZaYPuuYIybwgdOeY8vvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZrpksCO3auOU1kF5Zrx3A3aYR37Irql5rwOn8OCB1h3LIrPtnt1rBL6NkmdwtccPlLJ8tGNPpMTI7mqtiE5wnFiRJfslD8J3GYj2GjY7WWaluaQhyZJln8KxjyweXNSx8FSrYwaHoDGN2qHk0rpsZT+2Ppz0M44OXTrCjcAiQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap4kO7gm; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso626546a12.3
        for <cgroups@vger.kernel.org>; Thu, 07 May 2026 23:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778221676; x=1778826476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aekVbvEm7F7IL+LzVt0hfe3fiFB1n+NBAJxeB/SRo7M=;
        b=ap4kO7gmGBbGtM/H4EevdFTc6yNrwvtuYzQXxLthQDDKM8LNW9VRtS+NqrKW4aeeRl
         JnXiMgN74TqY6RvM20DUAPSopzHxkZ4wELoFX6CUQPHfWBtg6w9K+bts68JhJKzdPSbr
         ySO3MozX6yMuyDFYtW9BjtWmuljm7kQPb5VI3oDi16uDExMr0CPcgAWILlxl6r/8pioB
         ey1RS6+C47deNZ+qw6fK2BM9B85IFjgb4uCajqCLfLBm2pjMZIV5E8f2+PBWMHVQDasN
         ysn0qN3QEz98kfVhOLg3anNLMw7ia90oAE2dHNjYMjliSZpUfa+oQ9MB4s4/FE4T2KIZ
         ixTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778221676; x=1778826476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aekVbvEm7F7IL+LzVt0hfe3fiFB1n+NBAJxeB/SRo7M=;
        b=ezwXpzTdlFnLjxNSulR3hWexPcb3wmW2cup7+f4LXqbvTtZvJ8VKypraxpd2lA6lhC
         6i75nkyq4yuUA4renbACo8TYM60n5/TtM/j4zEoRgbZOuqGPn69xZ3PSMmeSpB43zN4Y
         qMH2+Rj4Acl8nvNQH7RCOYA2/HQWg1RWoZBEhXfDVLtyiM3tyIyS4V8G/RXyDz3H+F6o
         iF8CZatVwlNSLep0bHV/YRsNUznbPUFqfw4nKtw4v7HmRIKcG0ek73ssAlFYAAbOhT4y
         7Iq4i+xEZy4uSWveCyEzUwUZ5/07oDU+IlZgMM512K9eGiGw7zWUWTnGw31+uWB+sKD4
         iVAw==
X-Forwarded-Encrypted: i=1; AFNElJ9hxgWCffvabpOw7aYy/leDHyShJT6V40uL/+RR/HdqGdUq2c4T9nvWREo+BTJkCCrfs9z1M0Mw@vger.kernel.org
X-Gm-Message-State: AOJu0YxRWlaidkv4kwNuUxZsTEL8nfu/tZ3rbSQWB0UNkYX04pQPZFJV
	IUb5gsRGBMEKsbvoIOOnl5CyYVJGLUn8RQRtyDuoZ+h+mPHuL5OAorrf
X-Gm-Gg: Acq92OHQPVY1TNhafjyF0NVRrw7353iral8lpI9JGc5NWNhpHM/ksAHRdYNCWOglkeH
	p7bkjqwJSthvpOnuJjisX0s+tKBjS9mzmJa9Y0AW/yFq6UEFPImek+xruJNpnshMbyRw1osHTXY
	wiwWIewJzzSiEzzoN9ULkmVbQEBzeByGpxSbzCDCtaOgXk2Uw4aa5V6lsqgrTZO1rGOsCbaL5aq
	VbuZzVPJ7ALGxQxllVnd3RgrYhdPEfoN0C21MshaC+reLHWVhLCuZZoLouOQufES5JtVKPd70jW
	WVkCJFIFgwXUSl4ng/xG7bm9HhdsZxgqjDDksQuEX4MO0fUv/UsRNubbjnXc4bfR7ZuHySVk9xr
	HGTfvN77jwBdbab9LJOeBU887Yx32B1C1zjUUpRd52gI4ethoj2zKehy0wB5pvYEbd8Utk4CY7y
	UlI08YOkeVlnVbUfoavlueGv3mjLtsDOU=
X-Received: by 2002:a17:90a:d004:b0:35b:e4f8:7cc5 with SMTP id 98e67ed59e1d1-365acb88347mr11446508a91.25.1778221676187;
        Thu, 07 May 2026 23:27:56 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-366496d8b87sm476227a91.8.2026.05.07.23.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 23:27:55 -0700 (PDT)
Message-ID: <fc51f9f7-234d-4bc9-adab-a9b03cdb6c94@gmail.com>
Date: Fri, 8 May 2026 14:27:49 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: move PF_EXITING check before
 __GFP_HARDWALL in cpuset_current_node_allowed()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: longman@redhat.com, chenridong@huaweicloud.com, tj@kernel.org,
 hannes@cmpxchg.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260507105434.3266234-1-chenwandun@lixiang.com>
 <afx1u4kV-2kvgEEf@localhost.localdomain>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <afx1u4kV-2kvgEEf@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD4574F2764
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-15678-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenwandun1@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 5/7/26 20:33, Michal Koutný wrote:
> On Thu, May 07, 2026 at 06:54:34PM +0800, Chen Wandun <chenwandun1@gmail.com> wrote:
>> This makes it unreachable in the common case, so dying tasks can get
>> stuck in direct reclaim or even trigger OOM while trying to exit,
>> despite being allowed to allocate from any node.
> (OTOH, the caused OOM could select this task and bypass the hardwall. So
> this should only expedite but no unblock the exit path.)
>
>> Move the PF_EXITING check before __GFP_HARDWALL so that dying tasks
>> can allocate memory from any node to exit quickly, even when cpusets
>> are enabled.
> This makes sense to me on its own (given other hardwall exemptions,
> namely the commit c596d9f320aaf ("cpusets: allow TIF_MEMDIE threads to
> allocate anywhere")).
>
> Acked-by: Michal Koutný <mkoutny@suse.com>
>
>
> At first, I wondered whether this could happen on cpuset v2 -- it can --
> because only per-cpuset hardwalling is absent but the generic logic for
> GFP_USER allocations is still meant to be in place. Nevertheless, it
> occured to me we can spare callback_lock in this function (a separate
> chaneg for cpuset_current_node_allowed()):
>
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4213,6 +4213,9 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>          if (current->flags & PF_EXITING) /* Let dying task have memory */
>                  return true;
>
> +       if (is_in_v2_mode())
> +               return true;
> +
Thanks for the suggestion! I'll send a separate patch for this 
optimization. Best regards, Wandun
>          /* Not hardwall and node outside mems_allowed: scan up cpusets */
>          spin_lock_irqsave(&callback_lock, flags);
>
> Regards,
> Michal


