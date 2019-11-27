Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543BF10AF95
	for <lists+cgroups@lfdr.de>; Wed, 27 Nov 2019 13:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfK0MdC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Nov 2019 07:33:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28025 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbfK0MdC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Nov 2019 07:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574857980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7G/NuReZB7xzISC3L4MgIj09lT6rZziikJxj4TzKn4=;
        b=XlMYGN/G4qCp6iLs9hAz5ath6wyZtjzn4rvvJtuEfZu82f3kZpG+yf1IpaDfAs66uoz3iR
        m4Tr1abqnDeBuKsfnnpiKjmbeGas6DVu+zJA7EO8PTjIDsBWnlme6cYJypahyNlWyzDyaG
        Z1FTj4+KsvqWd60x0PJxEtDrJjBXRLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-f440qdchNRuE9swfiLNzXA-1; Wed, 27 Nov 2019 07:32:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8105A100551D;
        Wed, 27 Nov 2019 12:32:57 +0000 (UTC)
Received: from localhost (unknown [10.36.118.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 144CC66074;
        Wed, 27 Nov 2019 12:32:56 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, mike.kravetz@oracle.com, tj@kernel.org,
        lizefan@huawei.com, almasrymina@google.com
Subject: Re: [PATCH v2] mm: hugetlb controller for cgroups v2
References: <20191126195600.1453143-1-gscrivan@redhat.com>
        <20191126211805.GA617882@cmpxchg.org>
Date:   Wed, 27 Nov 2019 13:32:55 +0100
In-Reply-To: <20191126211805.GA617882@cmpxchg.org> (Johannes Weiner's message
        of "Tue, 26 Nov 2019 16:18:05 -0500")
Message-ID: <875zj5mrd4.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: f440qdchNRuE9swfiLNzXA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Tue, Nov 26, 2019 at 08:56:00PM +0100, Giuseppe Scrivano wrote:
>> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
>> index 2ac38bdc18a1..5a6b381e9b92 100644
>> --- a/mm/hugetlb_cgroup.c
>> +++ b/mm/hugetlb_cgroup.c
>> @@ -283,10 +283,55 @@ static u64 hugetlb_cgroup_read_u64(struct cgroup_s=
ubsys_state *css,
>>  =09}
>>  }
>> =20
>> +static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
>> +{
>> +=09int idx;
>> +=09u64 val;
>> +=09bool write_raw =3D false;
>> +=09struct cftype *cft =3D seq_cft(seq);
>> +=09unsigned long limit;
>> +=09struct page_counter *counter;
>> +=09struct hugetlb_cgroup *h_cg =3D hugetlb_cgroup_from_css(seq_css(seq)=
);
>> +
>> +=09idx =3D MEMFILE_IDX(cft->private);
>> +=09counter =3D &h_cg->hugepage[idx];
>> +
>> +=09switch (MEMFILE_ATTR(cft->private)) {
>> +=09case RES_USAGE:
>> +=09=09val =3D (u64)page_counter_read(counter);
>> +=09=09break;
>> +=09case RES_LIMIT:
>> +=09=09val =3D (u64)counter->max;
>> +=09=09break;
>> +=09case RES_MAX_USAGE:
>> +=09=09val =3D (u64)counter->watermark;
>> +=09=09break;
>
> This case is dead code now.
>
>> +=09case RES_FAILCNT:
>> +=09=09val =3D counter->failcnt;
>> +=09=09write_raw =3D true;
>> +=09=09break;
>> +=09default:
>> +=09=09BUG();
>> +=09}
>> +
>> +=09limit =3D round_down(PAGE_COUNTER_MAX,
>> +=09=09=09   1 << huge_page_order(&hstates[idx]));
>> +
>> +=09if (val =3D=3D limit && !write_raw)
>> +=09=09seq_puts(seq, "max\n");
>
> This branch applies (or should apply!) only to RES_LIMIT, never
> RES_USAGE or RES_FAILCNT.
>
>> +=09else if (write_raw)
>> +=09=09seq_printf(seq, "%llu\n", val);
>
> This applies only to RES_FAILCNT
>
>> +=09else
>> +=09=09seq_printf(seq, "%llu\n", val * PAGE_SIZE);
>
> And this applies to RES_USAGE and RES_LIMIT.
>
> But this seems unnecessarily obscure. Can you just put the
> seq_printf()s directly into the case statements?

yes, I'll fix it.  I'll also drop the branch for RES_FAILCNT as now that
is handled by hugetlb_events_show.

Thanks,
Giuseppe

