Return-Path: <cgroups+bounces-13644-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAk9AGILgmmCOQMAu9opvQ
	(envelope-from <cgroups+bounces-13644-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 15:51:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A9BDACEA
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 15:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1627D309DD7E
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AF23ACA5B;
	Tue,  3 Feb 2026 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Us9E4mi9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AADB3A960A
	for <cgroups@vger.kernel.org>; Tue,  3 Feb 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129985; cv=none; b=jn1Vx2bXU/NIi8m8jZRorR8yJVKYwcLzaqux2+uuuuFWAeeZxS73nlEjojY1hicfJAMDLJPfioAM0vlB/XXI4uKf8wmLfaSXmGtd5LTEW3ZTiwaf0HI60pY3nf/X1m0rf4yiQD8PFds1zVvRSDCPRhCLQwoyRY8K6QIBmfOUxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129985; c=relaxed/simple;
	bh=MAFQ5WMv7g5W0wOxe78cTJkvFbcpcxg6XzjQZ0plQGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyQP9GTp9G5Kr5FN4gG+huMSxhI+LlDbPUEHp6TklIkdLstSfoAcowWrVJemCnx72N9MS1ISj7nzWt/6R+TISjua8B+h512pCqIrihl5i+xSX68MrawruVsiBwPjiYV0IocBMjRQzYT0/jHNESRiYSZz9w/7sL5XRVJtRWxlhK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Us9E4mi9; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45c92df37fdso2660083b6e.3
        for <cgroups@vger.kernel.org>; Tue, 03 Feb 2026 06:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770129982; x=1770734782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8h3ESOfLmEqhgP4IZ+IYjjxYQsHrPxJrChAZKxI144=;
        b=Us9E4mi9jFMoqA0S8SMHFYNTZvhJeod7qw08PIuv185rTJHlmuqBPqZO/ZLoTOVKRt
         F+EL0Rxp4FdF3QhOusGdCE05bQQKLoRDGm39ALJiU1TIfRrs5ccnRErwaXeYqG2FZ3Xy
         sSsj1YHrXgv9nlgazkLCA6XJbFcwzOCK2DWuzkvoN3VMPSyLMYIygwxDNoUT8oLP6zIm
         nR1y6+Km4txn1UVchrf/LLhF5Ejck89FYcjBdEc6LUF7kIO47zAWiKw25tUzZnWh0yUc
         MUSlXwyvDN7eqydGAnyId5VQ9Vk+fQWQ5MqycdOBM/oAkCnrVPmf3KMt1ndMWxY5skLp
         KYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129982; x=1770734782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8h3ESOfLmEqhgP4IZ+IYjjxYQsHrPxJrChAZKxI144=;
        b=uJ3mNH7Zjv12L7tlKpVQqHEm15BT5yYDc0JQR2pCffpCUwYy5CfDKiBn8j5kKwx/bk
         glEEUky5RrEzYLCEDeGzqRD7vT3RZ8En4yTw+s74DMqaAVYHzoB3OoghV/n0JYkRuRIA
         H8yVOmnFtKGbvhavDEBysW1TsDoKMGx3LOKI7EB89FtjLLXUBNEWPanzie1muC9xSVpi
         VP/SfpIFEluoW61T4kIUq/84OOpjfL6ZDQMHVm6A2tW8vaBYfRvyGLwUKa0mMhAA04nW
         JXfAO/uGwoGKttS7gKm86/L1fOGwPD5xWgiGJDKaZwUebgpY7delU7OaB0OJp3zDiQPG
         glcA==
X-Forwarded-Encrypted: i=1; AJvYcCVP/jfNO45jiY1KuinTAZVFeG6qDz9aMWyebB+d3fnEK4nZR3hdS8bZNQ81D1LEPgxkZwU4EmGD@vger.kernel.org
X-Gm-Message-State: AOJu0YxwPuODGxT5yOcATc3cgcH6Wl4vZU695QshpjufTKwVavyw4xtV
	DIMxzkrJ0otqGA686vXX+N9nT/KmO5ez9lZzpMGlPu5OWTU5MlCXF9imNujU+MhHS78=
X-Gm-Gg: AZuq6aJLyAgIrXbsEtfYCpIOpJoRr6O9FlQ1+xOey/oE3oHlhO+sAzte8maUydaNbaT
	QKIRo2PpeTjJ85p6dBgIQDl2tmzP8hbTIcpyJOSj1aqxLHk5vTj/8BgD63R6AN88UCTpQ66sfVj
	VSL/7r1s3cbQvcR9ec+L8OCqj/e7jAuVHbAKnUDkU9RW3yC0wsyVk0eayAcjAU6zezXWVlKSXVB
	Xh45hwAg1VegIMGqJ6tNoL6247ejgLLT4f4XmIx3ximBnfMR/KhhC99TVXe8PupvY5ems15Z7HB
	7kaV78EkIPWcez7ceEwl27aWm5a7JYmU0FbpDaeTlqLTJEjzQhimMj+Zs12F+3X1d7RM52SWWw5
	te2lmx649ZSY8qvWLay9jQd+DTD7YNaGRc9hfIiMl7Os5XOj+t0/GMEq71d8ZV6ugJKq5sHJi3D
	+xrZmjOeW9a7sy9srqeuKeUrCMlPqnOyJas2i66+FXTFjBXsbIcn104SUmTFf+jJeZr4s6wQ==
X-Received: by 2002:a05:6808:1596:b0:459:a26c:2c3c with SMTP id 5614622812f47-45f34b9d012mr7359494b6e.26.1770129982125;
        Tue, 03 Feb 2026 06:46:22 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f20e38sm11231499b6e.10.2026.02.03.06.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 06:46:21 -0800 (PST)
Message-ID: <00babfab-5bd7-4b66-a765-f7c6689543c7@kernel.dk>
Date: Tue, 3 Feb 2026 07:46:20 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
To: Ming Lei <ming.lei@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: =?UTF-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>,
 syzkaller@googlegroups.com, tj@kernel.org, josef@toxicpanda.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai@fnnas.com
References: <CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com>
 <aYFlZf9p4cY0rIbc@fedora>
 <ffzrfu62npwacsl3225qqyjbhd6oue3x3rt46l2wcyp5oq4eli@26gvvst6hrmu>
 <aYHXzyRJbzFSohNm@fedora>
 <l55sz3sgogoyniecolvzscjamxqrxlzgk7w7scds3tt42z6atj@nrfvjqg2agib>
 <aYIBR6eeudRUQ9q8@fedora>
 <74zggmy53vzdb2q7sidvasnnlih5d5b4rp6jb6ibpka5zg7z7x@enl7iqw4prji>
 <aYII17gzXXPCTS3p@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aYII17gzXXPCTS3p@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	FREEMAIL_CC(0.00)[gmail.com,googlegroups.com,kernel.org,toxicpanda.com,vger.kernel.org,fnnas.com];
	TAGGED_FROM(0.00)[bounces-13644-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:mid]
X-Rspamd-Queue-Id: 55A9BDACEA
X-Rspamd-Action: no action

On 2/3/26 7:40 AM, Ming Lei wrote:
> On Tue, Feb 03, 2026 at 03:16:43PM +0100, Michal Koutný wrote:
>> On Tue, Feb 03, 2026 at 10:08:07PM +0800, Ming Lei <ming.lei@redhat.com> wrote:
>>> I can't parse your question, here blkg_release() simply needs to flush
>>> all stats. Why do you talk about preventing new flush? why is it related
>>> with this UAF?
>>
>> What prevents this fix:
>>
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -169,14 +169,6 @@ static void __blkg_release(struct rcu_head *rcu)
>>  #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
>>         WARN_ON(!bio_list_empty(&blkg->async_bios));
>>  #endif
>> -       /*
>> -        * Flush all the non-empty percpu lockless lists before releasing
>> -        * us, given these stat belongs to us.
>> -        *
>> -        * blkg_stat_lock is for serializing blkg stat update
>> -        */
>> -       for_each_possible_cpu(cpu)
>> -               __blkcg_rstat_flush(blkcg, cpu);
>>
>>         /* release the blkcg and parent blkg refs this blkg has been holding */
>>         css_put(&blkg->blkcg->css);
>> @@ -195,6 +187,15 @@ static void blkg_release(struct percpu_ref *ref)
>>  {
>>         struct blkcg_gq *blkg = container_of(ref, struct blkcg_gq, refcnt);
>>
>> +       /*
>> +        * Flush all the non-empty percpu lockless lists before releasing
>> +        * us, given these stat belongs to us.
>> +        *
>> +        * blkg_stat_lock is for serializing blkg stat update
>> +        */
>> +       for_each_possible_cpu(cpu)
>> +               __blkcg_rstat_flush(blkcg, cpu);
>> +
>>         call_rcu(&blkg->rcu_head, __blkg_release);
>>  }
> 
> This one looks more clever, can you send one formal patch?

I'll drop the previous one for now - I didn't really mind it,
but if we can fix it without, then yeah agree that's better.

-- 
Jens Axboe


