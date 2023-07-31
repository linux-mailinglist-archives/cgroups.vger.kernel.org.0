Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5D4769A25
	for <lists+cgroups@lfdr.de>; Mon, 31 Jul 2023 16:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjGaOzD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jul 2023 10:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGaOzD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jul 2023 10:55:03 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FBC115
        for <cgroups@vger.kernel.org>; Mon, 31 Jul 2023 07:55:02 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-563dae89bc9so2665491a12.2
        for <cgroups@vger.kernel.org>; Mon, 31 Jul 2023 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690815301; x=1691420101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B4Sgjqj8PJwtQbsiaEbfotX4EbaMjVvEmJGGtCQmdI=;
        b=MYEXAACmJf/TJazWT/7lXOvZf/LWvCukZvTAiPWDQJV5CRAKOl1c2oZgLTtycDWOJJ
         k4R4ttm63dmwe7HViTCZ6fTS8/Z7yhN+D+TlFSCuyittCBiN4pzQodzV//lD4mUiocb5
         D000Iyb6uiAlphAsyBkeq7DGy+ZMx5MFUv6vz/hn95INrmv2Hqs65nfW8p41K9X5BK7z
         cniR3jqFhhkmmZixJx8PB8HZyRuhbCz98yk1a1iCfhqUxbOVRYlDLHMY9osXnVI4ETxE
         UNm1Ly/epdhMWKPpzeExFLc+MT8nqH6/JK6UYahNKF3EwMZyex+/YF4HfHBs6ZOIlyRB
         l/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690815301; x=1691420101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5B4Sgjqj8PJwtQbsiaEbfotX4EbaMjVvEmJGGtCQmdI=;
        b=bLThvyfFGL7adqB7ql9eoQJEeIgxNDw6HNImsoE09c+VWZOGAlRWfI1lZG7DBaVnKI
         Q1P1KIR/XNmzcpeObjcgeQqTt6PavtgPcUVuIWdSLZpoEBgW0EdpQLdW8VwzBRSCRSND
         j++kV2wjJ/z3IawHelq1iEYBjMt5Lfir1wX3JpqwLf1ut28BtKMnnEH/SgdAdzcSJS+E
         PFKTyOB14jIBsVqOPylLPjeKRA5SmEwyZWUuAKht+6C1jmoUr1JXS37f6ICR3lMeQf9M
         XTNJIZO+1UUdjXRI2IHA6UhCglD1cTkiI/fTC8UrUGs0s56GY2h6kJ2Uz+L5XgL5+zT7
         tZOw==
X-Gm-Message-State: ABy/qLZXnntFrGzaNnArLf5/L3uPe3hiIsvC12ZByKCzYRrh8pSrkZQ4
        DuohWnKQtEtcwpv0shOaGNxPHZJ5GT407xEJHDJphazRC4c=
X-Google-Smtp-Source: APBJJlGse4cB3my+bnVuHQ6dWkfErY20wiKA+aT7wdDuGkDc+S8ZkJ97RI0tywdTWee/voVDOGyhOEy+9Bgmv6Mmn0M=
X-Received: by 2002:a17:90b:603:b0:268:2b38:c9b0 with SMTP id
 gb3-20020a17090b060300b002682b38c9b0mr8768654pjb.0.1690815301294; Mon, 31 Jul
 2023 07:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <477f3cd4-d2ec-4a0e-8e77-87968467d4a2@moroto.mountain>
In-Reply-To: <477f3cd4-d2ec-4a0e-8e77-87968467d4a2@moroto.mountain>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Mon, 31 Jul 2023 16:54:50 +0200
Message-ID: <CA+CLi1gUXg7u4yU7buxZK1DwR6JiX7R__93LP7xnQsX29e=F+Q@mail.gmail.com>
Subject: Re: [bug report] selftests: cgroup: add test_zswap with no kmem
 bypass test
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 31, 2023 at 9:23=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hello Domenico Cerasuolo,
>
> The patch 7c967f267b1d: "selftests: cgroup: add test_zswap with no
> kmem bypass test" from Jun 21, 2023 (linux-next), leads to the
> following Smatch static checker warning:
>
>         tools/testing/selftests/cgroup/test_zswap.c:211 test_no_kmem_bypa=
ss()
>         warn: unsigned 'stored_pages' is never less than zero.
>
> ./tools/testing/selftests/cgroup/test_zswap.c
>     197         /* Try to wakeup kswapd and let it push child memory to z=
swap */
>     198         set_min_free_kb(min_free_kb_high);
>     199         for (int i =3D 0; i < 20; i++) {
>     200                 size_t stored_pages;
>     201                 char *trigger_allocation =3D malloc(trigger_alloc=
ation_size);
>     202
>     203                 if (!trigger_allocation)
>     204                         break;
>     205                 for (int i =3D 0; i < trigger_allocation_size; i =
+=3D 4095)
>     206                         trigger_allocation[i] =3D 'b';
>     207                 usleep(100000);
>     208                 free(trigger_allocation);
>     209                 if (get_zswap_stored_pages(&stored_pages))
>     210                         break;
> --> 211                 if (stored_pages < 0)
>
> size_t can't be negative.  Is there any reason to check this even?

Hi Dan,

Thanks for reporting this, that check is indeed not needed. I should have
removed it when I refactored get_zswap_stored_pages and added the check
at line 209, I'll send a fix.

Thanks,
Domenico

>
>     212                         break;
>     213                 /* If memory was pushed to zswap, verify it belon=
gs to memcg */
>     214                 if (stored_pages > stored_pages_threshold) {
>     215                         int zswapped =3D cg_read_key_long(test_gr=
oup, "memory.stat", "zswapped ");
>     216                         int delta =3D stored_pages * 4096 - zswap=
ped;
>     217                         int result_ok =3D delta < stored_pages * =
4096 / 4;
>     218
>     219                         ret =3D result_ok ? KSFT_PASS : KSFT_FAIL=
;
>     220                         break;
>     221                 }
>     222         }
>     223
>     224         kill(child_pid, SIGTERM);
>
> regards,
> dan carpenter
