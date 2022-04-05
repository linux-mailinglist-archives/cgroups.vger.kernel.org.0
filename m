Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023BD4F33EF
	for <lists+cgroups@lfdr.de>; Tue,  5 Apr 2022 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344970AbiDEJyz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Apr 2022 05:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348912AbiDEJsp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Apr 2022 05:48:45 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B85CEE4DB
        for <cgroups@vger.kernel.org>; Tue,  5 Apr 2022 02:37:22 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id c4so6157724vkq.9
        for <cgroups@vger.kernel.org>; Tue, 05 Apr 2022 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=8YjdKne984sfE1TFRfUKmP3/44deiAaiEdvrqOqJMtM=;
        b=EqSwsfAKfrawy7t8TIrkzB/pZuBKFa36fgsssyo48iNUnMIxKKRCf1pXgUYzWJ7BgI
         85YRcfppFcrZOBaNypf0/3E5uGd4IvH7X5YoyMfDRrdevnX2q1BfQDMkv1yqKbtkPIZL
         nCw+nhuyrA65FLKhcnbp+0dIsdQ6b+1sviHN5uoUrUnzKg1eplyo1+haaW+BpwKQZl3k
         CrhlIYflzKyANa1FtIiXtV0mgZ5/ZIEKcYQ0ThZ+fJUbRY5vSNdD6DqWY++eVL7AeDHw
         04k4Wij0SCOFfWQ+uv7pcUNaGRfHsa4RCsz6y0MqNRBSuZyDz9mcycQYlh7KbH+sfWCv
         pOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8YjdKne984sfE1TFRfUKmP3/44deiAaiEdvrqOqJMtM=;
        b=2K1C5pwV5H/d8ZEZe0LdGwSHdjhB85APeMli74Wq5SGSAMR9WKKfiHVBlT6GpWTTF3
         RgoQlkt4vC1wODkya62j1X3NJyRAZH6nijWoqplVdTXmvHzRYwLGiKKpcFKH6kMqnCqr
         Vw9gYbiyCDm2Ul1js5PcmNwruzNmrmpDR8Zxft/TiHRVf1ryyl7YEgHGKOBx3vfqC/wz
         Sc2OjG2nmng6rLiQvv9L1iHshLKNlurZxLH87qk3026SL3hx2gtRBeiu76D18oXziETo
         jkvphiJT+hkt5aV/vCf4x9liSPhn/DuEhCFJlvcqyKnWt1DnhAaY5HdrLJVMHFwuim0E
         7pHw==
X-Gm-Message-State: AOAM533cFlZugDHtrNrKr8/k5b0oDs0yE2Uodh0O/Mn3OJIRaM2HAuee
        /Y47zKSyIsfHtuYdcxw61qdas9jpzDCNn4tiWr2tr9nGK8Y=
X-Google-Smtp-Source: ABdhPJxzwo8gGeAlDfgu0mu7KJA/bz8KmM62AZkCxbH/ZqKyhVV+UhKYmZ5+W3Naxiz5nUd7wgS/KbqjzfZmIdFk8Pk=
X-Received: by 2002:ac5:c3d0:0:b0:344:44f4:25c3 with SMTP id
 t16-20020ac5c3d0000000b0034444f425c3mr915664vkk.23.1649151441074; Tue, 05 Apr
 2022 02:37:21 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?0JXQvdGM0YjQuNC9INCQ0L3QtNGA0LXQuQ==?= 
        <and.enshin@gmail.com>
Date:   Tue, 5 Apr 2022 18:37:10 +0900
Message-ID: <CAHoi7SvtE971BuMWwnt=8V-DutO5=sgUGow637MiPq_+3NYbQg@mail.gmail.com>
Subject: reclaim memory from cgrouped app(/kernel)
To:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

does kernel reclaim memory inside cgroup - from apps running inside
cgroup and from part of kernel taking memory somehow related to this
cgroup - if there is no overall memory pressure in system but memory
usage in this particular cgroup is close to limit?

If yes, will kernel reclaim pages marked as MADV_FREE?

-- 
Best Regards,
Andrei Enshin
