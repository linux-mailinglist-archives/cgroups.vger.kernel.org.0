Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1457CF039
	for <lists+cgroups@lfdr.de>; Thu, 19 Oct 2023 08:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjJSGkX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Oct 2023 02:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJSGkW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Oct 2023 02:40:22 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A19A4;
        Wed, 18 Oct 2023 23:40:20 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66cfd0b2d58so48553446d6.2;
        Wed, 18 Oct 2023 23:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697697620; x=1698302420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg35d7x+h84itpcD18+miVVl1itiTnxbR9iVzbMahCQ=;
        b=JoUJXFmfiJbpanZ/WWfZfS8mLRKrKR/msz0HsUWnjv3lc3lJ5CqAyYYSyZcvMvExui
         aujehWA1vMcXHSb7xdbslpm/mUMzyIczWaMhGLCzjOCSrxPRXrOKzrG4dZWz3O22GJ91
         V+P5YjvZw1lYLMcMbboeKl6zuebf9iTFv5Bnb1Jp0BalMR11jxneOgWM1WwEvazIWYsC
         5hmT4lY8HNZT9qaHssu4f8+NavT7uVNbeRDZG+iysU5mqZTMBU3rfmTGLKa8FhG6nDss
         3TdxbrnMShK7KL0Vaei2E3lM/MbEJFDXw4tYH1f1oyZyaCbFxov/Q3sf4D2EkXPmuQuk
         AXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697697620; x=1698302420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg35d7x+h84itpcD18+miVVl1itiTnxbR9iVzbMahCQ=;
        b=o31FywNXuNKxgwiIL2gITbZDum2VBUSJ8nOjNwtb6Hcez36CVxnQQr5StkDmv6i9Sx
         2afQ/ARfhSAAz4G2PHIyq+8orUMlKESPCa3PfyaMo8N/f6y2dFRjfPD+mVOVaNEkJx7F
         cqw8/iyT1zouxN0M3S6081BqzxgcA741G5PixU4giQ3KsqjEA2IGfbIWrJ3J5aYGjg2W
         Xr0Ii4SZ/XmeQuMnqww2rgFOcUOgBfkfkktEy/IVsn2eEmONEJf+UjENvV2/n69jp8/W
         pH9zEMJRFf1ypBjW3aAnKmRRWYY4yn3w2erKvtSLrpAgnNpjkH0HwN7RaYJXtzxDJrns
         4OAw==
X-Gm-Message-State: AOJu0YztSiK1mFul8VDB7n7bDVnkzgmfyJW4grVU56RNnencmM1aYd1+
        K7H7VFwxbbxR/EQeB0iQcYFOY7siq4Zsb5Ah3HU=
X-Google-Smtp-Source: AGHT+IGp2j/lrBPItJqYBTctWu7zbHtXLnmRYGA5OUDhNBJxYuMNyeUAMInz+GWzXj3w7zpVq6f3cEwctRRpR/vH190=
X-Received: by 2002:a0c:e4d1:0:b0:66d:863a:b752 with SMTP id
 g17-20020a0ce4d1000000b0066d863ab752mr1388160qvm.22.1697697619887; Wed, 18
 Oct 2023 23:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231017124546.24608-1-laoar.shao@gmail.com> <20231017124546.24608-3-laoar.shao@gmail.com>
 <ZS-nrsIMFUia8uPI@slm.duckdns.org>
In-Reply-To: <ZS-nrsIMFUia8uPI@slm.duckdns.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 19 Oct 2023 14:39:44 +0800
Message-ID: <CALOAHbD77Z7BFktf6fHfOXKHaHbvhhZJ5rxPhtC7gGG4AgWHfA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/9] cgroup: Eliminate the need for
 cgroup_mutex in proc_cgroup_show()
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 18, 2023 at 5:38=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Oct 17, 2023 at 12:45:39PM +0000, Yafang Shao wrote:
> > Results in output like:
> >
> >   7995:name=3Dcgrp2: (deleted)
> >   8594:name=3Dcgrp1: (deleted)
>
> Just skip them? What would userspace do with the above information?

It should be useless to userspace.
will skip it.

--=20
Regards
Yafang
