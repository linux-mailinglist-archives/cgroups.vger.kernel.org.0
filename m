Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBD87BBE9F
	for <lists+cgroups@lfdr.de>; Fri,  6 Oct 2023 20:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjJFSXy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Oct 2023 14:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjJFSXv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Oct 2023 14:23:51 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E56BE;
        Fri,  6 Oct 2023 11:23:50 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79fa387fb96so103911839f.1;
        Fri, 06 Oct 2023 11:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696616630; x=1697221430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o68PLV4udEbPFs/VVjQWU3h52B5qcFcaG2B/iYOksIU=;
        b=jI0W2RhyxXuXPYSh+O2Wo7g8uHlgub0RfGqrQ+hjpxiBLm7J+dTdaLNfJ+BKMSgryW
         0+7gO2YqKosK2R2eiXXtUkx18CaqDP3BiXzxKq1FVA2pdwV4/TSQ8zactEN99lfA1UEh
         otFokpz4sJVlnJQyP12IZLXkdz+Vs1/IozD4USwA1ML93ejwcNyBy/vzsn2i9fhvSbaH
         K3UMfmVSgmhbyp0+zpIo7PD1r2LnLzrcXsRzui4cziOEM2SdLIfRntWAfqSsGnnNruh9
         //vtminrFdc8h+fHfbs5lNKpD+vjRRL66AgnaHL8WUrX8dmjLNchKtnNqmGefpMW5pG9
         nQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696616630; x=1697221430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o68PLV4udEbPFs/VVjQWU3h52B5qcFcaG2B/iYOksIU=;
        b=w8FuzzMWikJaZ/aZpNqmEE//UsHGFuLRq+V53hO48L/zNbhLAvHXVcfHbxktYsQPvP
         SgGZ3QhTKqUXa3IcsmnoXaTCrf76T3iXaop53UGshXglGKB7nLS4sAHonzyHHrGTbz0E
         G7v2YINK5+Wdwz8DOLXTaZOxff7iDw71EDtx5czPwfGYfiWwBSHEWYrcjWNZGnVXuxF5
         wvbiOJXBuxbyUmc7VzJeOLi1/XX0zM+MP2dn275PngRdk2PV3VS9r0kFFqMiyq/8OYiA
         N8exN6i0OoqH1Prh8ZRZdyQXYC4L9cxUSAkE7xpTewUjhTQRaZWqBB1ZJR8STc+NxuZV
         oZhg==
X-Gm-Message-State: AOJu0YxwRH/98uoZLLwcSvsBCuHOb3cf/i8MwRARkLW8yVGJuXV87CpD
        mdkVRd/GWOJD/iQSTwegx5UeRZdDewaJ5r4ZFDSVstb62PU=
X-Google-Smtp-Source: AGHT+IEBpBAP7dyRy7MudKX46NCt62sD1tPli23qMuGiDSsnfTavL2MRkqh3a5CnLZWonhU3SnQAEZD0KHB/B6jUGyw=
X-Received: by 2002:a5d:9910:0:b0:780:c787:637b with SMTP id
 x16-20020a5d9910000000b00780c787637bmr9406112iol.0.1696616630114; Fri, 06 Oct
 2023 11:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231003001828.2554080-3-nphamcs@gmail.com> <20231004194506.946908-1-nphamcs@gmail.com>
 <20231006102523.cc8ea46aeda6ef0a03ae22a2@linux-foundation.org>
In-Reply-To: <20231006102523.cc8ea46aeda6ef0a03ae22a2@linux-foundation.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 6 Oct 2023 11:23:38 -0700
Message-ID: <CAKEwX=OJJ9vbYs8__R8hroK0nQHSiyZ=L5u5xxemzUrLyTCXZg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hugetlb: memcg: account hugetlb-backed memory in
 memory controller (fix)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 6, 2023 at 10:25=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed,  4 Oct 2023 12:45:06 -0700 Nhat Pham <nphamcs@gmail.com> wrote:
>
> > Ensure hugetlb folio migration also transfers the memcg metadata.
> >
> > This fixlet should be squashed to the following patch:
> > https://lore.kernel.org/lkml/20231003001828.2554080-3-nphamcs@gmail.com=
/
> > hugetlb: memcg: account hugetlb-backed memory in memory controller
> >
>
> I've rather lost track of what's going on here.  I'll drop the series
> "hugetlb memcg accounting" v3.  Please resend everything and let's try
> again.
>

Sure thing! I'll send a v4 with everything cleaned up + squashed
in a moment. Apologies for the confusion.
