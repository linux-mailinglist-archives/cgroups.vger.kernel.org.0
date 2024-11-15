Return-Path: <cgroups+bounces-5584-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59279CF645
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 21:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C122DB38BAE
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 20:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E388518C018;
	Fri, 15 Nov 2024 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIs0H9KN"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AC81E2821
	for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702349; cv=none; b=JBbPgkqswPvikOgf7d9wV4MGCaBxCpPv+1SAYbMZvGlGknvBOhT6Mqi+u3C2278+ynf41ckzjikF6LXSRpvnwaJmdwoTPfhGQVqklW3S/nkhL1HobnsOiwHryU2l8Lzt0b/xnK9RgTqvaYZONquLmKNch5z07gdZ22Z4T5Aksts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702349; c=relaxed/simple;
	bh=vzB88Ab0K9g7gx/HZQf5Qt3upMzQRUJK5J17p+p5qss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqJjjdTUPacWniMr76CIuc2ik3Wv8ZxLfnIj4Wv0C7JKdeQ3/QF6kjBJBogsSw65eUWz1hTxfsugN39f1UACgOEdGJLIA4p42Dt8lDY343SXSlhy3d/5zuw9QGICZZi57PzleMqNm2wrZTyCTb3hgBwISLBe0eCB/Z6xMU1vRuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QIs0H9KN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731702347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNLrlgsuyCSQO136ZlOgDlHV4KMR1L8gzLEmcIW3BjM=;
	b=QIs0H9KNmyIHcil8hv6r3gGxT9Clt3F1fld5GYvspOz1MKlF57tI9O2rypvg16rdB3kTPx
	e5ygxvMBpKW+dW81HRlB2O+8OP1eRbmGrrM1LZh/hbX88jQWrSofJaqboJ8Lq4UyZsa8a7
	7egoa3bgi0aL4xckGdMw5O6oY3HWBZ8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-r8zMiyzOO8-D7QyWANDW_g-1; Fri, 15 Nov 2024 15:25:43 -0500
X-MC-Unique: r8zMiyzOO8-D7QyWANDW_g-1
X-Mimecast-MFC-AGG-ID: r8zMiyzOO8-D7QyWANDW_g
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5eb8b4b3eeaso1887431eaf.2
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 12:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731702342; x=1732307142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNLrlgsuyCSQO136ZlOgDlHV4KMR1L8gzLEmcIW3BjM=;
        b=JTzoMqpzcgoR1WjUtNi0INqyclD7xrwqnWYxIWEcl4P5+W7AUM9whM00UBsUNJDBYB
         4PphAgYj/hbiDXIv241CEXhMfZKwRS/k5ANl3wF11RQmKthlZxF0YYVe7u66I7wALzN4
         wEHIaYa8+7rIAKzsy5ZAj6O73a5rnYxoSSfKysqgggCRL4l8htFln/nvXAqkfvkCpzpL
         h/cKWxSiqGbT9XLMwxa7XdBcpPLfwv+Kkfa8NlyekJuUHnA/nUYKcgxdJ46uRZqD5USJ
         T/0vgopXsz65LOxffVC1yOferB66OYE0z8oDEWbl7v+MI5ONYiwPwCLXsmJ8SJGkA2cv
         sRMA==
X-Forwarded-Encrypted: i=1; AJvYcCXLxlY4+Xex6Aaugz/Y9LaofrIDt8df4hJ355pm4iGF8HsTcVkz0htun/QcG/WoqU2D/kuATIZ6@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2yOU34xjmtzUhlwwpMk2WuDigmRpGmalzVDrGbu55c+b/C3z
	yj7d9lSWQgeouJY11wvak+wpGFO7h2Pk2CXgmYYtwiUVb4pjdLHqCuH135H6c1p88XFsucFtsSa
	kuG+4zqRQJCcOUNk5TR1R27OL4XlKcPJIFlOfh8GnljDkSCg2JpyCbYCkiuW+yuw/g9F6+c/gd9
	Vmgi1sfQSsmFt27qzKbXn6z5DPGok2NQ==
X-Received: by 2002:a05:6871:e085:b0:295:91a0:af1 with SMTP id 586e51a60fabf-2962de09fa0mr4330104fac.19.1731702342157;
        Fri, 15 Nov 2024 12:25:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHprnkP4mcnKY9AIEZogy1RG7ERmEnfoV7JX0QKAbhQCgxNP7EEumthj14YA/khDgoSXi5sWHjd6wPh6Z6kCCs=
X-Received: by 2002:a05:6871:e085:b0:295:91a0:af1 with SMTP id
 586e51a60fabf-2962de09fa0mr4330087fac.19.1731702341911; Fri, 15 Nov 2024
 12:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108054831.2094883-3-costa.shul@redhat.com> <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
In-Reply-To: <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Fri, 15 Nov 2024 22:25:05 +0200
Message-ID: <CADDUTFwYKjbPnzdzQA0ZjW4w3pHBsoZBQ6Ua5QbFp=X2-GfGtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] blk-mq: isolate CPUs from hctx
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ming.lei@redhat.com, Jens Axboe <axboe@kernel.dk>, Waiman Long <longman@redhat.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Michal.

Isolation of CPUs from blk_mq_hw_ctx during boot is already handled on
call hierarchy:
...
        nvme_probe()
                nvme_alloc_admin_tag_set()
                        blk_mq_alloc_queue()
                                blk_mq_init_allocated_queue()
                                        blk_mq_map_swqueue()

blk_mq_map_swqueue() performs:
for_each_cpu(cpu, hctx->cpumask) {
        if (cpu_is_isolated(cpu))
                cpumask_clear_cpu(cpu, hctx->cpumask);
}

static inline bool cpu_is_isolated(int cpu)
{
        return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
                !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
               cpuset_cpu_is_isolated(cpu);
}

cpu_is_isolated() is introduced by  3232e7aad11e5.

Thanks,
Costa


On Fri, 15 Nov 2024 at 17:45, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello.
>
> On Fri, Nov 08, 2024 at 07:48:30AM GMT, Costa Shulyupin <costa.shul@redha=
t.com> wrote:
> > Cgroups allow configuring isolated_cpus at runtime.
> > However, blk-mq may still use managed interrupts on the
> > newly isolated CPUs.
> >
> > Rebuild hctx->cpumask considering isolated CPUs to avoid
> > managed interrupts on those CPUs and reclaim non-isolated ones.
> >
> > The patch is based on
> > isolation: Exclude dynamically isolated CPUs from housekeeping masks:
> > https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com=
/
>
> Even based on that this seems incomplete to me the CPUs that are part of
> isolcpus mask on boot time won't be excluded from this?
> IOW, isolating CPUs from blk_mq_hw_ctx would only be possible via cpuset
> but not "statically" throught the cmdline option, or would it?
>
> Thanks,
> Michal
>
> (-Cc: lizefan.x@bytedance.com)


