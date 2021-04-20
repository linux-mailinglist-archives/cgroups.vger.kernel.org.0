Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD153655BD
	for <lists+cgroups@lfdr.de>; Tue, 20 Apr 2021 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhDTJtN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Apr 2021 05:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhDTJtK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Apr 2021 05:49:10 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC57C06174A
        for <cgroups@vger.kernel.org>; Tue, 20 Apr 2021 02:48:39 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id f21so1725549ioh.8
        for <cgroups@vger.kernel.org>; Tue, 20 Apr 2021 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=q4PsK1IB6S8NhB6JTxksI5uH1aB7Bg8w1NjrAu/sUPM=;
        b=dKFnCjwDxYwTvpOtv5Kznjgvr2Pz+BblbsK/1VgtM/ezwULuTHIuWfAvlES7ZY02/q
         1W6oy0s4vdBPooQYOJQlElGbJldAZMnpM5Lf2cYwAahHUgtBecoskmYOQBSrWeHeJu7h
         BqXFlWUIkHFJErSSP+xBy3dsqup8kkVXbCTVwujcCUeqiou7S46aIN0Fa1Cl/oOUnz7o
         MB1l6LgUBe/LtxrBHBge9LWuQlUtj9ZLtP1LZytydZ/uhYuMFlmRA3I8e7U04HgRK7rK
         KaoEWdU9HAhvITz0ArIkBa2kVQUpFUajUr06dfRDJ1BvFQaRfi61J0DWi8NBQOn58ZlA
         amNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=q4PsK1IB6S8NhB6JTxksI5uH1aB7Bg8w1NjrAu/sUPM=;
        b=ADKn0XWQkNR9nnFCHOzq7ntNbBqK4HlJsV9l1zAOdSPWgccprpimPu2FC47EAU0aAn
         my5+DhvjKnhbMo0ZiXwulzMSTQxTOzcTpbjT7RWcB7MVv3i85y1HYCvBkZjwJ/FbtcTm
         qAoFsCE4/BTtLjux2hQvxA1wKgRd8bnYQGRtfHdbz0FOG1oqwBydj8v9SxYOiCIkA1LV
         1NJ8EK92fUc7MhwFqJq/Op2YxgaN4fcqeBHQQEpVTQmpQ2B/GW0QMR9mGl+7nv4ZzYCC
         52ZrgQLEQTOxXVXMdkoY7rlPnkiJ2xUW9OvagmagjJZ2SXVopkt22FVW5HSYATXi9KOx
         gA2A==
X-Gm-Message-State: AOAM533+4jRwmoIcKxXXd7kdFT5dTjp7oNF+TqlAu5JD4joK1fdFQILp
        eqTXakEcX48Vnnp0shzZ7jwFewLAxwXjy8r7Gq7qIxQBUeg=
X-Google-Smtp-Source: ABdhPJxUmOOAhVCD22/3O5Z+7f2MmEuP6UiUFf0/wnpyY+6HFSYn8GmxTuRTEBisz3wVdGiYW8u5UCZMZ0o1aVlLmLI=
X-Received: by 2002:a05:6602:2bc5:: with SMTP id s5mr900407iov.91.1618912119095;
 Tue, 20 Apr 2021 02:48:39 -0700 (PDT)
MIME-Version: 1.0
From:   nanzi yang <952508578nanziyang@gmail.com>
Date:   Tue, 20 Apr 2021 17:48:28 +0800
Message-ID: <CADRjgdb2NsYikK13GZw3xk+C95q8M3LEqnoCtS-=nPhoy3-mSQ@mail.gmail.com>
Subject: Report Bug to Linux Control Group
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, shenwenbo@zju.edu.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, our team has found a problem in fs system on Linux kernel v5.10,
leading to DoS attacks.



The struct file can be exhausted by normal users by calling multiple
syscalls such as timerfd_create/pipe/open etc. Although the rlimit
limits the max fds could be opened by a single process. A normal user
can fork multiple processes, repeatedly make the
timerfd_create/pipe/open syscalls and exhaust all struct files. As a
result, all struct-file-allocation related operations of all other
users will fail.



In fact, we try this attack inside a deprivileged docker container
without any capabilities. The processes in the docker can exhaust all
struct-file on the host kernel. We use a machine with 16G memory. We
start 2000 processes, each process with a 1024 limit. In total, around
1613400 number struct-file are consumed and there is no available
struct-file in the kernel. The total consumed memory is less than 2G,
which is small, so the memory control group can not help.



They are caused by the code snippets listed below:

/*----------------fs/file_table.c----------------*/

   ......

134 struct file *alloc_empty_file(int flags, const struct cred *cred)

135 {

        ......

142     if (get_nr_files() >= files_stat.max_files && !capable(CAP_SYS_ADMIN)) {

               ......

147            if (percpu_counter_sum_positive(&nr_files) >=
files_stat.max_files)

148                   goto over;

149     }

       ......

157 over:

       ......

163     return ERR_PTR(-ENFILE);

164 }

/*-----------------------------------------------*/

The code at line 147 could be triggered by syscalls
timerfd_create/pipe/open etc. Besides, there are no  Linux control
groups or Linux namespaces that can limit or isolate the struct file
resources. Is there necessary to create a new control group or
namespace to defend against this attack?



Looking forward to your reply!


                                                       Nanzi Yang
