Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA7DA121A24
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2019 20:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfLPTkc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Dec 2019 14:40:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51269 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbfLPTkb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Dec 2019 14:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576525230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eftXlax3AyojAMdFlUzaSF1jqccKdLfnifDsEr30bnE=;
        b=DrKSarpxhtNguaIoBa+DM2EE2zJH68u78N+MIE020CFjM+H9vY6COkX6MmXosV2UjFyUHT
        QLA32YhLbG2XTcyFa8NJPC6QcaOlcphpGbXTfAFOn1T5LuNQd8vVl+YF91zvrc4nDvD/52
        0GUkp+5PfsmlcfBK6H5gnodzNHyoRa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-lHo_8zn6PxaGVaBc0m0Vyg-1; Mon, 16 Dec 2019 14:40:27 -0500
X-MC-Unique: lHo_8zn6PxaGVaBc0m0Vyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3EF68017DF;
        Mon, 16 Dec 2019 19:40:25 +0000 (UTC)
Received: from localhost (ovpn-116-109.ams2.redhat.com [10.36.116.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FB0060933;
        Mon, 16 Dec 2019 19:40:24 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, almasrymina@google.com
Subject: Re: [PATCH v5] mm: hugetlb controller for cgroups v2
References: <20191213102808.295966-1-gscrivan@redhat.com>
        <20191216160704.GE20677@blackbody.suse.cz>
Date:   Mon, 16 Dec 2019 20:40:22 +0100
In-Reply-To: <20191216160704.GE20677@blackbody.suse.cz> ("Michal
 =?utf-8?Q?Koutn=C3=BD=22's?=
        message of "Mon, 16 Dec 2019 17:07:04 +0100")
Message-ID: <87fthkjbyx.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

Michal Koutn=C3=BD <mkoutny@suse.com> writes:

>> +	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages,
>> +				     &counter)) {
>>  		ret =3D -ENOMEM;
>> +		hugetlb_event(h_cg, idx, HUGETLB_MAX);
> Here should be something like
>
> -		hugetlb_event(h_cg, idx, HUGETLB_MAX);
> +		hugetlb_event(hugetlb_cgroup_from_counter(counter), idx, HUGETLB_MAX);
>
> in order to have consistent behavior with memcg events (because
> page_counter_try_charge may fail higher in the hierarchy than h_cg).

thanks for the review and the hint.  I've sent another version, where
the event is generated in the correct cgroup as memcg does.

Giuseppe

