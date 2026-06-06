Return-Path: <cgroups+bounces-16685-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7OVZJNOUJGrB8wEAu9opvQ
	(envelope-from <cgroups+bounces-16685-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 06 Jun 2026 23:44:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9D264E6D7
	for <lists+cgroups@lfdr.de>; Sat, 06 Jun 2026 23:44:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lankhorst.se header.s=default header.b=cokYzf8J;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16685-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16685-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lankhorst.se;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A32E3300D879
	for <lists+cgroups@lfdr.de>; Sat,  6 Jun 2026 21:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B853CF043;
	Sat,  6 Jun 2026 21:44:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B2D3CEB9B;
	Sat,  6 Jun 2026 21:44:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780782257; cv=none; b=ddOohR6ISAULbVFY1NgsYG9sCaTmgiJK+l2UiCcr3tulEjYLNTcblRvg8uWEWdMtKUPyoeXSLvHxrlLSUYE0Yzf1lKZs2pNnvF6k/tJGTFYtWc/45fn9FT7fb3Gmx0WG99LP0MXILtFx7kiTWP3uiuD+vHHEkbJqn+nVJIw1LK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780782257; c=relaxed/simple;
	bh=MdIOfrIYmEsea8JqrCO5kqj7L6obXVdS4UOehQCzvFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHE0JxZESFSNeuqLG+KFYbupB975wJAz1JbpmC+794hGO0IL594gN36HD8PSAdLF3BCU0JAj57qzabtwirNr+GOkoe+T56GkDbkgLww0Oi3H+fMpCeG66/VAgbGSoeXD+iTEOHehUQ9NUbtlx1Y+AFxu0FmuyEmQq9O7fq60KeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=cokYzf8J; arc=none smtp.client-ip=141.105.120.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1780782246;
	bh=MdIOfrIYmEsea8JqrCO5kqj7L6obXVdS4UOehQCzvFc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cokYzf8J9EoIWph8Oal0dMi/2nhT9HAyFVggMxfRLDjsDAu+JsGtVVq+SUqdXkTMh
	 zljbi0tsTYZ6xN6j+aazpiyPEnZefZf2S1hF6JyIigfwcWRvqzGwjKWXhOgiRFxCig
	 S6cePn3RaSjvtAqduu41y9oQmHwErGqnUe+N5ZTdZKtcAtPnicf+eG31SWklqWpFPQ
	 6fS4FAYGuFZbMHaBPe/5WXocj0TBTNCVDIOy6O8aWz0GFcDvQQIBjIJBtmAR/b3nuE
	 cs0LdpQCAVrlF8FMf3fxDe7yhyNUt0YcikUPcBggP/Gj3wHSZGQXFOnEL4mBh3oaZU
	 N06EJUZER09oQ==
Message-ID: <f00e7771-cd70-4c86-9fac-149897e02b12@lankhorst.se>
Date: Sat, 6 Jun 2026 23:44:10 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
To: Natalie Vock <natalie.vock@gmx.de>, Eric Chanudet <echanude@redhat.com>,
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>
References: <20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com>
 <271b1c16-3c3c-4a1e-b09e-c4361c63814c@gmx.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <271b1c16-3c3c-4a1e-b09e-c4361c63814c@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lankhorst.se,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lankhorst.se:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:natalie.vock@gmx.de,m:echanude@redhat.com,m:mripard@kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:aesteve@redhat.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmx.de,redhat.com,kernel.org,cmpxchg.org,suse.com];
	FORGED_SENDER(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16685-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[lankhorst.se:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchwork.freedesktop.org:url,vger.kernel.org:from_smtp,lankhorst.se:mid,lankhorst.se:from_mime,lankhorst.se:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA9D264E6D7

Hey,

On 6/6/26 18:31, Natalie Vock wrote:
> On 6/6/26 00:44, Eric Chanudet wrote:
>> Accept only one "region value" pair entry for the dmem.max, dmem.min,
>> dmem.low files.>
>> This changes the UAPI that otherwise accepted multiple lines for setting
>> multiple entries in one write. No existing user is known to rely on
>> writing multiple regions in a single write.
> 
> Ugh, shoot.
> 
> For dmem.low specifically, there already are some userspace thingies floating around that may write more than one region/value pairs.
> 
> These thingies all depend on that one patchset for dmemcg protection that I should really get around to merging[1]. Since the userspace utilities depend on not-yet-merged patches, they sort of have to expect stuff changing under their belts, so I wouldn't really consider those users a blocker by necessity.
> 
> As I see it, we could go down one of two paths:
> 1. We go ahead with the patch as proposed, and I make sure that the users I know of adapt. Could be a bit icky wrt. "do not break userspace" rules, but since the already use non-merged UAPIs in one place, you can argue that these users kind of have to expect breakage.
> 2. We use the old handling allowing multiple lines for dmem.min and dmem.low only. This preserves compatibility but uglifies the code by quite a bit.
> 
> All things considered, I think I personally would prefer going with 1. and taking the patch as proposed and just having one codepath handling every limit file. Just highlighting this so we don't do it on accident.
> 
> [1] https://patchwork.freedesktop.org/series/163183/
> 

I prefer option 1 as well, but would like an ack from one of the core cgroup maintainers too,
and what Maxime's opinion on this as well.

Kind regards,

~Maarten Lankhorst

> Some more review comments inline.
> 
>>
>> Processing multiple regions in dmemcg_limit_write() could quietly change
>> first limits before failing on a later one and returning an error to the
>> writer, with no indication some changes occurred.
>>
>> Signed-off-by: Eric Chanudet <echanude@redhat.com>
>> ---
>> Follow up from discussions on a previous thread[1].
>> If Albert's series[2] lands, I can cleanup and prepare some kunits for
>> these as well.
>> [1] https://lore.kernel.org/all/158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lankhorst.se/
>> [2] https://lore.kernel.org/all/20260519-kunit_cgroups-v4-1-f6c2f498fae4@redhat.com/
>> ---
>>   kernel/cgroup/dmem.c | 70 +++++++++++++++++++---------------------------------
>>   1 file changed, 26 insertions(+), 44 deletions(-)
>>
>> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
>> index 6430c7ce1e0372f59f1313163fb7630ce49ac1ef..113ee88e276296bccb4def546adf5cc175d7f0be 100644
>> --- a/kernel/cgroup/dmem.c
>> +++ b/kernel/cgroup/dmem.c
>> @@ -734,57 +734,39 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
>>                    void (*apply)(struct dmem_cgroup_pool_state *, u64))
>>   {
>>       struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
>> -    int err = 0;
>> -
>> -    while (buf && !err) {
>> -        struct dmem_cgroup_pool_state *pool = NULL;
>> -        char *options, *region_name;
>> -        struct dmem_cgroup_region *region;
>> -        u64 new_limit;
>> -
>> -        options = buf;
>> -        buf = strchr(buf, '\n');
>> -        if (buf)
>> -            *buf++ = '\0';
>> -
>> -        options = strstrip(options);
>> -
>> -        /* eat empty lines */
>> -        if (!options[0])
>> -            continue;
>> -
>> -        region_name = strsep(&options, " \t");
>> -        if (!region_name[0])
>> -            continue;
>> -
>> -        if (!options || !*options)
>> -            return -EINVAL;
>> +    struct dmem_cgroup_pool_state *pool;
>> +    struct dmem_cgroup_region *region;
>> +    char *region_name;
>> +    u64 new_limit;
>> +    int err;
>>   -        rcu_read_lock();
>> -        region = dmemcg_get_region_by_name(region_name);
>> -        rcu_read_unlock();
>> +    buf = strstrip(buf);
>> +    region_name = strsep(&buf, " \t");
>> +    if (!region_name[0] || !buf)
> 
> If buf is NULL, isn't strsep(&buf, ...) also NULL? region_name[0] would therefore be a NULL pointer deref. Flipping the order of the logical or should be enough to prevent this.
> 
>> +        return -EINVAL;
>>   -        if (!region)
>> -            return -EINVAL;
>> +    rcu_read_lock();
>> +    region = dmemcg_get_region_by_name(region_name);
>> +    rcu_read_unlock();
>> +    if (!region)
>> +        return -EINVAL;
>>   -        err = dmemcg_parse_limit(options, &new_limit);
>> -        if (err < 0)
>> -            goto out_put;
>> +    buf = strstrip(buf);
> 
> Do we start allowing extra spaces between region and limit as well? Would also be fine by me, it doesn't break anything, just highlighting that it's a change in behavior. Should perhaps be documented in the commit message, too.
> 
> Also, you should be able to use skip_spaces() here for an equivalent result. I'm not strongly opinionated on either way, but using skip_spaces() indicates more clearly that this can only remove spaces at the start.

> 
> Best,
> Natalie
> 
>> +    err = dmemcg_parse_limit(buf, &new_limit);
>> +    if (err < 0)
>> +        goto out_put;
>>   -        pool = get_cg_pool_unlocked(dmemcs, region);
>> -        if (IS_ERR(pool)) {
>> -            err = PTR_ERR(pool);
>> -            goto out_put;
>> -        }
>> +    pool = get_cg_pool_unlocked(dmemcs, region);
>> +    if (IS_ERR(pool)) {
>> +        err = PTR_ERR(pool);
>> +        goto out_put;
>> +    }
>>   -        /* And commit */
>> -        apply(pool, new_limit);
>> -        dmemcg_pool_put(pool);
>> +    apply(pool, new_limit);
>> +    dmemcg_pool_put(pool);
>>     out_put:
>> -        kref_put(&region->ref, dmemcg_free_region);
>> -    }
>> -
>> +    kref_put(&region->ref, dmemcg_free_region);
>>         return err ?: nbytes;
>>   }
>>
>> ---
>> base-commit: 640c57d6ca1346a1c2363a3f473b405af979e046
>> change-id: 20260605-cgroup-dmem-write-single-region-9bf05b6d995d
>>
>> Best regards,
> 


