Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6BE7BCBBC
	for <lists+cgroups@lfdr.de>; Sun,  8 Oct 2023 04:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjJHCdZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 22:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjJHCdY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 22:33:24 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7A9BA;
        Sat,  7 Oct 2023 19:33:24 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-65b0a54d436so19066316d6.3;
        Sat, 07 Oct 2023 19:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696732403; x=1697337203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ikh1apyO/cYzzl3dWb5PfZ1kqq51Fc1Op26TQbNzRo=;
        b=k6xOwXodLzHgL7BmbpOcAstx9CbnmthpSmKEp4zapGbWv9RvY8iEkKuOBRap9DBkpu
         3rxTps+dZNcuRSBqyl7Yi5F0xOTHsqS4Qj8KkxMErcAHwzPx4ynwbXC9R7NB1Zk5vF3Z
         cnRKCpov75+DvLRgMdbwr2aKyvw2TDfUPo8UpmqPKdq35947MdVQjFilC8WApex59Am1
         VADNtbUiaCOlV6UnbJP/AqRTH77NgTeKBXVD7CcMlDK2j/mRWGKhLK91dAskldxxe6VH
         GCJV6tSv8u8C4T/fRbNREpuNGULPqK45GtSaqbygLlHmlaVnOW5QdQoqRqDrvBPvLUeB
         Z0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696732403; x=1697337203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ikh1apyO/cYzzl3dWb5PfZ1kqq51Fc1Op26TQbNzRo=;
        b=QMJM1D83bbIKnGsCL85ZSUMJKTc+Rm5t7KFJTyFM2Xx+Y32D7C/1I8xv5aJPn6toNm
         NhhaCRAuU2j7skHNNOFi8mKo7TydVuifshKrw7AApvETYqt7z2e8WkNMuG1Lc9ws8KM9
         olklrqOEntPjRvmnWkMfqwr/5eAeo8VvQY/yoJBneUqsZPZoYWb83/MweKCZT+qtO8RE
         ID5MEYU4KIm9skoWsE+kJ3Tcmp/APuFVdCK63xORpAw7II75AHPs9vHgJs+4UU/OOTsr
         pdwJqWf0SlJ1h9fv9Z4xFnE5NhdrS/w84be4krzl2qelA9B/+9R6Sp/f1jNSHTe4UhW/
         mslA==
X-Gm-Message-State: AOJu0YxXAYrX3A2f/geJsf14L+qmHXQ4XWzge/YjfCp+E3Hg0toJxsi4
        FL23FEvVsLsyiUMDvr1sTVITPUbiRp0NqPT22Yx43YeUJTuZpA==
X-Google-Smtp-Source: AGHT+IHkm88N32BNVpSS8eS+KkMleeLyiER0LfoL8vjmw4sIbqhNGT19Fp5QWkSMV70Vgdijasy3WO+/eZXYN5u+kKw=
X-Received: by 2002:a05:6214:5c06:b0:65b:2008:8a3e with SMTP id
 ly6-20020a0562145c0600b0065b20088a3emr12690704qvb.46.1696732403007; Sat, 07
 Oct 2023 19:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231007140304.4390-1-laoar.shao@gmail.com> <20231007140304.4390-2-laoar.shao@gmail.com>
 <ZSF-TeyAxq6xqcII@slm.duckdns.org>
In-Reply-To: <ZSF-TeyAxq6xqcII@slm.duckdns.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 8 Oct 2023 10:32:46 +0800
Message-ID: <CALOAHbCmiObOGxgiQW-itoQb+JPKpsvk2-d_st4Ksjp+nU+6Hg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/8] cgroup: Don't have to hold cgroup_mutex
 in task_cgroup_from_root()
To:     Tejun Heo <tj@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
        sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Oct 7, 2023 at 11:50=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Sat, Oct 07, 2023 at 02:02:57PM +0000, Yafang Shao wrote:
> > The task cannot modify cgroups if we have already acquired the
> > css_set_lock, thus eliminating the need to hold the cgroup_mutex. Follo=
wing
> > this change, task_cgroup_from_root() can be employed in non-sleepable c=
ontexts.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> Maybe just drop lockdep_assert_held(&cgroup_mutex) from
> cset_cgroup_from_root()?

It seems we can do it.
will do it in the next version.

--=20
Regards
Yafang
