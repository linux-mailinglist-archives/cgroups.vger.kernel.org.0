Return-Path: <cgroups+bounces-14785-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLkJH9VcsmkZMAAAu9opvQ
	(envelope-from <cgroups+bounces-14785-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 07:27:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B8526DA18
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 07:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D4A83024162
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 06:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B22352C3C;
	Thu, 12 Mar 2026 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiDMRYk6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrDJmEQH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75FB303CA0
	for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296850; cv=pass; b=DzmWuFfwvkNOQBNqwqxAD1QkkC2nH8rbbc2OuhM3F4hY+xTBFCRL3JSv8/SV8zqxCSGaXOXM8xuZ95+c2TxoU5m7z/nzHirrheYc4xA3okN2xEIkTjH0Qi0ezW0YQXf4H3KyjIhUQsTz2O2ueJRdoLauc1ubZeemFTHSdh7+KqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296850; c=relaxed/simple;
	bh=Po5VbDI3dsUYUexHvnvx0I8KnYPHdZR/pSpQyqf3bfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpZ9Z3FyRQB8a4hxjW5DgSxZAEI/xkNXaJmJuSNrRuw5SF4E+mR1df4N+Y0OXcf/HwLN4PvznT2ji8+HqZOXI0lxBhAizcWmjfhqr5foGvSwbSdnPxn+RgIVIXFDIvcW/0LRjFWM5tMeUQhCEmmu+BRpURhjH++G7Hi/p5ONutU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiDMRYk6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrDJmEQH; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773296848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KA7MHHq5ctaVMhUhQrU15S9h10dJC9tJn/h4KcAT1oA=;
	b=SiDMRYk6d4QaOk1Jm6zHVCBIZPo0SpYiwGeI+1NGF1qOqasHnvGcWvqABv1RB2E194zs87
	EvJhDcqC32cMCaWmx/C6y6X49Z0meTg4v5i0hbURVNUut/HD8Y+6X1AgldO7DMc6Jk+Gmq
	CbqhVfdlv9N3xFkfsjopRT5o+2QeWjQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-j1w-Yn1QNkCRXx6r8kTWkQ-1; Thu, 12 Mar 2026 02:27:25 -0400
X-MC-Unique: j1w-Yn1QNkCRXx6r8kTWkQ-1
X-Mimecast-MFC-AGG-ID: j1w-Yn1QNkCRXx6r8kTWkQ_1773296844
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-66142e571c9so493300a12.3
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 23:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773296844; cv=none;
        d=google.com; s=arc-20240605;
        b=O5hUYW9GU61ZieewReaVyuWNPACdHdF7foDFy1uxQ4h5xE1YiuvMniB7pjrKjCNIJs
         RHX9fFJMv2GfgzHMJcKXBznmx5uc1pdtOVTAGF991HTJuY2SmlUxh3e3n4I6nCX9pOhq
         8HkZGF7JcTZ472ua00Z2DGX/Q/U4sGyod1WcQUzScx/16Y+k02dv2CfrrMISsGq81Wyz
         +92iiLHJHNhEA8LHGbFIgd57ivaSCuqiyuCuR+k+b6Uns/dxspnNcUBO8v7X4D7nEHF0
         oOdpG4vkF57VZeQlv74GHIyfX54DEZ2WTBHxSQmErIm+EGKWiU2sd1cypTVnHMXQLpmJ
         liQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KA7MHHq5ctaVMhUhQrU15S9h10dJC9tJn/h4KcAT1oA=;
        fh=lTv4Egv1YL19blEdIsCaDGQKhTMvfpvoRew+d/QOkgk=;
        b=WooPQ/G3tkclGQDCTrFAGv8/K3izYj01uI6jAhIEQ/vE79gGh+Vu8GOkhRulD5D1gR
         a2R9PmUJTofs85Zr9KYWEpX4rXpobN3Y9EIvwUoSoiTZ9x8+N4htCkU6O2ptS2b5Hzz9
         7RDav22efOd4uj0HLzML1FpI2GXbR1todkuUX24Uyh5A3XkILR8GUyDWuUgKAdR6Ujg2
         5EhR9dL4dJxgPT90PHqBVwxsZknAISaOfaAXcDQiP9tqnwQIaUnNovJ6ekZ/OJM62LnJ
         6gFmiVUv3df25quHU4rN3gL9/ZQ7OAC95Z/tws2auLwmMLFsR52BtPXsk0JemxBOs+f5
         H/HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773296844; x=1773901644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA7MHHq5ctaVMhUhQrU15S9h10dJC9tJn/h4KcAT1oA=;
        b=OrDJmEQH6O/avIOtkAVply2SyV0v5jnus/As3rVnZZX33ACFzvzYu+cpF21QYbceAb
         wRAy+HTKRFxrj9Pr4DUnna0NwpjIiFG+ofWL7hSxpbPF6SWEu/bhUAo6T7GvDJak4gJP
         lZiI9MfhGhXW0cif7d8rH2YCaKKyQvInIlSZkNz7dUxkrw55v/g+Hx36AYFlj+Okm74Q
         QUw/F6iI+Ej6kmCgmVwXgR04Ofq0S8J7QN3Sqc0gn+FkMwYYmeU9ynfmF3uRwuLH7W9K
         ZbtEsQqKaM2OKFC8/oCSfnNvxRovtvQJLQMMw8Vfdeu/Q6pg/nAX4W5KwLpRV17/dQ2k
         BdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773296844; x=1773901644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KA7MHHq5ctaVMhUhQrU15S9h10dJC9tJn/h4KcAT1oA=;
        b=gY5Zj/CEJHQA5Sbaw/iLmtxqkMovQ13yHelD2H4KGzUanYMUDF0EFvKLo1TZyGe/6p
         ghcrk3dnbVeXXRuC8djv9JD8e3SEwcunsJQAZP1IELJLflpQd+zU5T7iArbMNfd82Lzz
         OTqlIV5YcAU12+wzaYP6BY+mTv9l+ehJ2P6ej0J8ufasLi4CbUYC7hR2kmTSULFqWiAG
         yQQQva3TarVEUxqUWQ1vm1jBk6lPJh5Wbl4AoiLL04nsj0xwpuSGgfugRvcXer5iYrfA
         ki3jeXikpoATfBfEp5YXKe7mTiZr8BertchLYmsNwLlie5Dq4Z1T9sSv5JdTHJWKM8RE
         RvBA==
X-Gm-Message-State: AOJu0YwCLuOkhOmZuGKfd0rSRQH6il9dhn+N+cMXzfK3HOuZhC7oJTDU
	WHZqzHbfX0AAHiJqJ5OxqFmLA4euVEBz9AvZ/DJV6+arPFI5taYb+BEC1aB2PynUE/ge9Uw19EE
	AxAf3i4a4rixXu+iCd6ONn4Z2Puq7L2y+KFcJQXPavRiUac/RWUSA6JgdmzQSHwKOJYKQuWl9kO
	q49KXjCbL0D9WvmvwuwLcf62hVPPCcIEr9Dl/HfbLGftNcTwyfcg==
X-Gm-Gg: ATEYQzzoP+7NPCwr2aoeNgYXonCraXzLAP2ik1lrMxVoPurLEmslo71Xbghvecl/7vt
	ki7rZNLCle5KD09PIEmcjYVhJDS5YMq7eSVT+2qzBktmTuQIM008fUZrOFEIW15C3q+mHFsv0zV
	AQpFbDI0WPgFLi4ReZ3BGmYdivc4v6qQPbTkwjN5BKbZyH4nObOFK4Yvrq2xh/Nb3xGPjCMquD2
	8lzIhs=
X-Received: by 2002:a05:6402:254f:b0:661:51a1:8d18 with SMTP id 4fb4d7f45d1cf-6631a8d7acamr2574653a12.31.1773296843966;
        Wed, 11 Mar 2026 23:27:23 -0700 (PDT)
X-Received: by 2002:a05:6402:254f:b0:661:51a1:8d18 with SMTP id
 4fb4d7f45d1cf-6631a8d7acamr2574642a12.31.1773296843581; Wed, 11 Mar 2026
 23:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEnjF8FxM2CGgGC0R42R7R4=udHMtkwV9bCVcw7NDq7KTZMLkg@mail.gmail.com>
 <4238fec3-1a37-4924-b13e-a42d2454412c@redhat.com>
In-Reply-To: <4238fec3-1a37-4924-b13e-a42d2454412c@redhat.com>
From: Lucas Liu <hongzliu@redhat.com>
Date: Thu, 12 Mar 2026 14:27:12 +0800
X-Gm-Features: AaiRm51s2sbZ-V7wlsSb_KbYKHb1lBQV8FzGRHjVYoDhNs9_i_DNWXmOCFLGp2U
Message-ID: <CAEnjF8EMW1F9WQE5rSVMeU5aoYi2sJGruxiaj8SxXtVHp6m8tA@mail.gmail.com>
Subject: Re: [ISSUE] cgroup: test_percpu_basic fails on PREEMPT_RT due to lazy
 percpu stat flushing
To: Waiman Long <longman@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Li Wang <liwan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-14785-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongzliu@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D6B8526DA18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Waiman:
Thanks for responding, I have tried Li Wang's patch, The problem has been f=
ixed.

# ./test_kmem
ok 1 test_kmem_basic
ok 2 test_kmem_memcg_deletion
ok 3 test_kmem_proc_kpagecgroup
ok 4 test_kmem_kernel_stacks
ok 5 test_kmem_dead_cgroups
ok 6 test_percpu_basic
[root@localhost cgroup]# bash run.sh
run 100 times...
--------------------------------------
proccess: 100/100  status: [  OK  ]  failure: 0
--------------------------------------
done
overall: 100
ok: 100
fail: 0


For the lazy percpu stat flushing, I assume this is expected behavior
for RT kernels? So Li Wang's patch can be our final solution? Please
correct me if I am wrong.

Thanks

On Wed, Mar 11, 2026 at 10:17=E2=80=AFPM Waiman Long <longman@redhat.com> w=
rote:
>
> On 3/11/26 4:49 AM, Lucas Liu wrote:
> > Hi recently I met this issue
> >   ./test_kmem
> > ok 1 test_kmem_basic
> > ok 2 test_kmem_memcg_deletion
> > ok 3 test_kmem_proc_kpagecgroup
> > ok 4 test_kmem_kernel_stacks
> > ok 5 test_kmem_dead_cgroups
> > memory.current 24514560
> > percpu 15280000
> > not ok 6 test_percpu_basic
> >
> > In this test the memory.current 24514560, percpu 15280000, Diff ~9.2MB.
> >
> > #define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())
> >
> > in this part (8cpus) MAX_VMSTAT_ERROR is 4M memory. On the RT kernel,
> > the labs(current - percpu) is 9.2M, that is the root cause for this
> > failure. I am not sure what value is suitable for this case(2M per cpu
> > maybe?)
>
> Li Wang had posted patches to address some of the problems in this test.
>
> https://lore.kernel.org/lkml/20260306071843.149147-2-liwang@redhat.com/
>
> It could be the case that lazy percpu stat flushing can also be a factor
> here. In this case, we may need to reread the stat counters again
> several time with some delay to solve this problem.
>
> Cheers,
> Longman
>


