Return-Path: <cgroups+bounces-14991-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNhgCo4LwWmtPwQAu9opvQ
	(envelope-from <cgroups+bounces-14991-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 10:44:46 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E4A2EF46B
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 10:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2514B300CA36
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 09:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77606387341;
	Mon, 23 Mar 2026 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuoL+M4r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jnN4XEa/"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E3D35E529
	for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259079; cv=none; b=EsaC9jIFHClttrSo273miLcYTVHNktf6DMGbXVlu7VUKAb8GIMsbihkEsbheVjdsqJIr2jTUNUreBs1S9R4Q6uL0x478/pLSyeCFT6387V2EuIGJbUGoyqQkK9gBmvrl+T4jxGJ95KqRFKjToBV7v60PYXabMvtvEaB5gIPYHG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259079; c=relaxed/simple;
	bh=XYhbbjpDV0ET9lpzrkJgS6mYpcOgfUEU7VTc6kLP4UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud4Xmhq1UWqoyQDFkRDaQVBxGZ2v/oFNATt32nOb6j+lNIsYVTpmwQZU1/FB0OpXUGxYdCTluOT2sHhicL4FKN+44Vh94MDK5yFcMri+82HutNp/1oQw+vEdQRtMK2r8pZYZfkI4LajjKM10xsSb/NsKiCO5GmYEqTus1YIHGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuoL+M4r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jnN4XEa/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774259076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LcMB5gIX03eono8rt37+6BTZoTufylHEu17I/eh9tE=;
	b=DuoL+M4rpNnsY485WkmpPP/v4w4M4yYopCGHGIOGHmJ8aoeI0MmM7Dcz//PoltaF1dfELT
	0HDOHVfuIEaY2n3xzFCzsBlodCXr910MXE4lfK3f9nXwG4Mzo3oi+iPJexdXW8t9b0MVoc
	Povb/PZeoFxuF1N6SoOAYe0zezgJIis=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-leot1jsqNOS5k1HT9aKU7w-1; Mon, 23 Mar 2026 05:44:34 -0400
X-MC-Unique: leot1jsqNOS5k1HT9aKU7w-1
X-Mimecast-MFC-AGG-ID: leot1jsqNOS5k1HT9aKU7w_1774259074
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829a535ad50so2429045b3a.2
        for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 02:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774259073; x=1774863873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LcMB5gIX03eono8rt37+6BTZoTufylHEu17I/eh9tE=;
        b=jnN4XEa/YmZZveP6wlU5CqkVv47uZboQ6OYTGQo2VaLeb8VXabDo6ErzIUKpT3TVb1
         5y4tAf2hS7eYvgvr7M2TEB8r7KsgEfC2SuVWq3NT9dPnBzFsSqSS6DPs5apfCnaIzdKA
         VU0Q/n/OO/xnHIQi5VzrcEIVblZrGjzPgWjBK452cVjPilmN4axnih4a/rBbh9H2RGto
         ZvA7hcyJBr+Yu1UmWg/knavHtZ9D0sHzHTQp1IR2F3wVx22FCYmf52BBWrNXQkg73Kgq
         vZzsKMxkGD4TCFKUriqFopLka2QiROj61ZTiWNTTnPZbHFq7u9MSZ2j/Q/OXD/O9mqf8
         UbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774259073; x=1774863873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LcMB5gIX03eono8rt37+6BTZoTufylHEu17I/eh9tE=;
        b=YtLauYgUWkCAhXCr+4bUK5dt6IMJZXDx01ghmhs/DvYJqKZt4GQypo12vV3az2DdW6
         b0R4t7PtiaZsWcQDNeGPlxau9oJbJjaW/ZnMYHxEbCB7QXQeu5R4UxFe5VGq1PRzpHR6
         Fkp+wvKzV60j6mtx64Js6JsfX2A3xYbNkVPA+EQSNdrj5npuJSmwZzvHiC3rbKyypOza
         vzrmZUY4UDLCfqGlBTBYcfoEYMs7k9EkxmHqmWmr2voddR5Kg7ZgqWSXK/IJT99aqoPe
         3yxHEY5dxVP+qb7ea14rDLneGIgaBpfsgMCzkHU++pttClr7UWMhR+mO0HKmhUxfatGL
         zCHA==
X-Forwarded-Encrypted: i=1; AJvYcCVi3/eLGQZ+Q5kp6KGxrToCdEQHl2X5phHO+d6RkJ3lZQq3NpP7wbjA0O4XGGgwC71mK1XxSC1q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9EhnCSbrPv7z1JgqTN9sHAT6QS4CSZxRluH+HvNCny1UpAnHy
	/1GmuB7dUYYiTMJB80NCpOBTkKTSSHfgqhBgM5FhMhjBOpcCKuaUPm7KliLXvc629Lvu0cqEyc1
	xrODvrBdNHVrBehqWEIDQrFz4zBIYX6zQG5hXuBX2+UGh4zwkpAmi0Vso3Hk=
X-Gm-Gg: ATEYQzxDZQMzktz8B+WQhL3w1aXwgS6CwwSZzB/gM7KXp7haE1JReAbeMYKSmy0nbDH
	9WoJnDYBSN0gJh4UlWst6Qd6e0W9it7VlP5wabr+4wzSpQqwI6P2ffnmQ38l2+GAn7AZz82erLZ
	iersrAKE7+VHamOxD2mO6bCL9gWL+BBuANeIVLIzv3FfyqZMQdwd+AiW+EUZ/svHuJVnjOkkXad
	5o/boYplq2HtfTyD96DkQFILX2NRAtMV/lcnPYIxRSVxcGb4myvXWAAyjRda9Srwgd9MvrIFq2O
	resmfbbWZnBc70uxsJzFeLoFfjlgEHw76YT3FT8Q7LvRfws/RlWIONfbCKrF0re6Zvd78odlZZS
	fQ3Ulr0TpewPgTpie4g==
X-Received: by 2002:a05:6a00:12e2:b0:82a:7dfd:9757 with SMTP id d2e1a72fcca58-82a8c2525d6mr10198878b3a.4.1774259073591;
        Mon, 23 Mar 2026 02:44:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:12e2:b0:82a:7dfd:9757 with SMTP id d2e1a72fcca58-82a8c2525d6mr10198855b3a.4.1774259073192;
        Mon, 23 Mar 2026 02:44:33 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c681sm10471814b3a.37.2026.03.23.02.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:44:32 -0700 (PDT)
Date: Mon, 23 Mar 2026 17:44:29 +0800
From: Li Wang <liwang@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	James Houghton <jthoughton@google.com>,
	Sebastian Chlad <sebastianchlad@gmail.com>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>, Li Wang <liwan@redhat.com>
Subject: Re: [PATCH v2 7/7] selftests: memcg: Treat failure for zeroing sock
 in test_memcg_sock as XFAIL
Message-ID: <acELfUqXlKVWFcDT@redhat.com>
References: <20260320204241.1613861-1-longman@redhat.com>
 <20260320204241.1613861-8-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320204241.1613861-8-longman@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-14991-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8E4A2EF46B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 04:42:41PM -0400, Waiman Long wrote:
> Although there is supposed to be a periodic and asynchronous flush of
> stats every 2 seconds, the actual time lag between succesive runs can
> actually vary quite a bit. In fact, I have seen time lag of up to 10s
> of seconds in some cases.
> 
> At the end of test_memcg_sock, it waits up to 3 seconds for the
> "sock" attribute of memory.stat to go back down to 0. Obviously it
> may occasionally fail especially when the kernel has large page size
> (e.g. 64k). Treat this failure as an expected failure (XFAIL) to
> distinguish it from the other failure cases.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 5336be5ed2f5..af3e8fe4e50e 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -1486,12 +1486,21 @@ static int test_memcg_sock(const char *root)
>  	 * Poll memory.stat for up to 3 seconds (~FLUSH_TIME plus some
>  	 * scheduling slack) and require that the "sock " counter
>  	 * eventually drops to zero.
> +	 *
> +	 * The actual run-to-run elapse time between consecutive run
> +	 * of asynchronous memcg rstat flush may varies quite a bit.
> +	 * So the 3 seconds wait time may not be enough for the "sock"
> +	 * counter to go down to 0. Treat it as a XFAIL instead of
> +	 * a FAIL.
>  	 */
>  	sock_post = cg_read_key_long_poll(memcg, "memory.stat", "sock ", 0,
>  					 MEMCG_SOCKSTAT_WAIT_RETRIES,
>  					 DEFAULT_WAIT_INTERVAL_US);
> -	if (sock_post)
> +	if (sock_post) {
> +		if (sock_post > 0)
> +			ret = KSFT_XFAIL;

XFAIL means "expected failure" and is intended for known kernel bugs or
unsupported features. A timing issue where the test simply doesn't wait
long enough probably not an expected failure, it's a test that needs a
longer timeout.

I'm wondering can we just enlarge the MEMCG_SOCKSTAT_WAIT_RETRIES value?
e.g. from 30 to 150


-- 
Regards,
Li Wang


