Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F007B5A52F6
	for <lists+cgroups@lfdr.de>; Mon, 29 Aug 2022 19:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiH2RQe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Aug 2022 13:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiH2RQa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Aug 2022 13:16:30 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B57E83055
        for <cgroups@vger.kernel.org>; Mon, 29 Aug 2022 10:16:26 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z23so5854268ljk.1
        for <cgroups@vger.kernel.org>; Mon, 29 Aug 2022 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=X6VmYsgMW8K15KBs3jUfjE+heWPeLcY8CtwqiX8/U7g=;
        b=M4QGkW3ptdqm71GWxKRUeBll7XiacNWh893RwsJPYgWFWBnh9Zggap/ig8nQavJHpH
         DCapLVvJudLtUcz0FT33djVjCUi5hWprvjjCm5gk4OnBbhHxmh2tQzzKA+tWFKq0g8Pb
         /v0iVSe7/FxUMWYlg2inn9QaOdW5M1w0AT/rFg6v4lAoglF3/+s6Zo9hcVg2suMFyOd7
         IpU+XP2RYOznfsY8w7yYcVnbIaKG+kK1q/K/hOuWLWflbOacLchd7nP02MME8kq8Onix
         xKxtXEsV+ZeQRNiwyBgwbWJO/Tx5Ggy+XJDwkhUbyWfSTDb2YXeQOT+3D1ASXRYStZRC
         Yelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=X6VmYsgMW8K15KBs3jUfjE+heWPeLcY8CtwqiX8/U7g=;
        b=tr+gZdxR4+AlagEIJDZo7/rKZGf1nkIpaCsPlXmH7bHvohGSy9TB0qlACnzJGNezkZ
         dnEhUJbrM9DAyu8y4a6Gf+CjqwPS9j7D4CHjjC912EjTdZfv2oEvAEmWDWkMwhq5LDZX
         eqE/JHofXPXjaEmDUo3pfzjtATa9ypcpOwt9u/jNp4eHXsh10Bh5fYX2bPK88GSYTh6o
         8uLIzvOcRb8rgsFDE8Zf4gSdLZmGWaFXAtLCAQq2wAD8O+lc2/PIzsaC68CAsVX1ApLk
         kocdoaEwhmt6yMgk7AYBrQXax/Y9LDN0qcgy8k6DauADO4o3fovqota47y8RSRQvX43T
         WEJQ==
X-Gm-Message-State: ACgBeo3iU5lVTUdcSZeGcCzN7lLFLdFGdscD7f324EP/kFADfWW0T2J6
        EkdiZRT8R+IpC2WgS647TzGyc9nayel7abcr
X-Google-Smtp-Source: AA6agR6XkSwuyuOa7nSxiO3bMtK9mwVP4zTT79pC9QgGB145SPQVWI4HXf4h3Ov/WTyCrn+UTjSz6g==
X-Received: by 2002:a2e:b894:0:b0:25e:cb1f:365d with SMTP id r20-20020a2eb894000000b0025ecb1f365dmr5720153ljp.285.1661793384553;
        Mon, 29 Aug 2022 10:16:24 -0700 (PDT)
Received: from smtpclient.apple ([89.21.157.196])
        by smtp.gmail.com with ESMTPSA id 3-20020ac25f03000000b0048b08f0c4e9sm1330772lfq.176.2022.08.29.10.16.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2022 10:16:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: cgroups v2 cpuset partition bug
From:   =?utf-8?B?TWF4aW0g4oCcTUFYUEFJTuKAnSBNYWthcm92?= 
        <maxpain177@gmail.com>
In-Reply-To: <ef183fe9-8458-8a7f-2b8e-1c38666b6399@redhat.com>
Date:   Mon, 29 Aug 2022 20:16:23 +0300
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <26A2A485-B70C-4361-8368-1A0081570E7C@gmail.com>
References: <C98773C9-F5ED-4664-BED1-5C03351130D4@gmail.com>
 <YwT/BNqIdCEyUpFR@slm.duckdns.org>
 <ef183fe9-8458-8a7f-2b8e-1c38666b6399@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi. I used top and htop programs to check what CPU is using, and it's =
showing that this task is running on CPU 2, so I think it shows the =
correct CPU that is currently being used.
Please note that the containerd process has /system/runtime cgroup, =
which inherits cpuset from the root cgroup. /system/runtime cgroup =
doesn't have any cpuset settings. Maybe this is the reason?

I tried to remove the lowlatency group with cpuset.cpus.partition=3Droot =
and do taskset -cp 4 1079 manually, and it works without any restart.

I updated my post on StackExchange and added some new screenshots, so =
please check it out.

> On 29 Aug 2022, at 18:24, Waiman Long <longman@redhat.com> wrote:
>=20
> On 8/23/22 12:23, Tejun Heo wrote:
>> (cc'ing Waiman for visibilty)
>>=20
>> On Tue, Aug 23, 2022 at 03:13:30PM +0300, Maxim =E2=80=9CMAXPAIN=E2=80=9D=
 Makarov wrote:
>>> Hello. I have no idea where I can ask questions about cgroups v2. I =
have a problem with cpuset partitions.
>>> Could you please, check this question?
>>> =
https://unix.stackexchange.com/questions/714454/cgroups-v2-cpuset-doesnt-t=
ake-an-effect-without-process-restart
>=20
> When a partition is created, the cpuset code will update the cpu =
affinity of the tasks in the parent cpuset using update_tasks_cpumask(). =
This function will set the new cpu affinity for those tasks and move it =
over to the new cpus. However, if the tasks aren't running at the time, =
the move may be delayed until those tasks are waken up. The fact the =
task affinity is correct means that the cpuset code has done the right =
thing.
>=20
> I am not sure what tool do you use to check the task's cpus. I believe =
the tool may show what cpu the task is previously running on. It does =
not means the the task will run on that cpu when it is waken up. It is =
only a bug if the task is running and it is on the wrong cpu.
>=20
> Cheers,
> Longman
>=20

