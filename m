Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C068895C88
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2019 12:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfHTKsO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Aug 2019 06:48:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37102 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbfHTKsO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Aug 2019 06:48:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so11876694wrt.4
        for <cgroups@vger.kernel.org>; Tue, 20 Aug 2019 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8YhdYjqe+CTt77YsPRFesv990RDPmX6UdhabR8/j8l8=;
        b=dgG7nSaegDa/f34PzKpV/NDTRDbAf4Tn8ESgBGCCvyBUctxq98sGkgyEW3giHSJqxI
         yUlLAH58TbPebsNICnhxbv2FhjuVdm71H1yyw5DTYaHXUr2mcxTajrDMX8YQgXP6K59l
         KMlqgNId7X/0kUtpLyRyUbCvjdArWdQ99nv9N56pBQaxb3fB9btAbzRfZfUnDKcyc653
         FieTVsewJyyWcgh+hruCD2sviZgKsiiLWf5EamLzSfUSXhw0pHGE0djlhbWl5DfBK/qL
         x+kZDh5BOO4jY2T8+YBs/0azHTKHddDMvZO7kBrbJSv/Sg/eUgpzfCZxDVIdodTyN4C4
         JChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8YhdYjqe+CTt77YsPRFesv990RDPmX6UdhabR8/j8l8=;
        b=FphsFqHhz015mvRbX9YZkOvU7DPayXv3sIgevmPMh09YwPgO+FHr3k22KPpbMtS5rg
         /yNxyFYejV8zluH+s3L0n9s9nnxiibZYljTKbUFgGfuYhbf8rHFhTLj5Ut0s6h45vMlB
         mvNx8he7arAFMT6lM1Et302lCVrv5iqzzEKKBOpQ6mhtVE9SGSMtLiIK08cwZ2wyMPG4
         u13oKbdxS7Wp6ua6+stHcA/lDAZfgzDMFQliuSjdkPh+Q/1qtYuvDhee72SaZ6VKgvgu
         ieCgtUv/FAud2G5g/08/PuiT9P9WNLjluGx3c6wcOtzx99ck90Rwn1XAj5sbyytimLxC
         dwFA==
X-Gm-Message-State: APjAAAWXBi2fO5lKRBb2pgn3LgHadnT/yZyIzLoxh7l6DnKisJ1CRTfz
        5A5Gl5NagUgFMj+zoYy1jxtwLA==
X-Google-Smtp-Source: APXvYqwc3MstBJr5Jkxt0X3//Ms1r9i69Vio0VuTKiCfoKN0uTDQcpIcE5vYcPNH7zQIlsf1GoelnQ==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr20045745wrv.174.1566298092001;
        Tue, 20 Aug 2019 03:48:12 -0700 (PDT)
Received: from [192.168.0.101] (88-147-37-138.dyn.eolo.it. [88.147.37.138])
        by smtp.gmail.com with ESMTPSA id c11sm14244247wrs.86.2019.08.20.03.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 03:48:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCHSET block/for-next] IO cost model based work-conserving
 porportional controller
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190614175642.GA657710@devbig004.ftw2.facebook.com>
Date:   Tue, 20 Aug 2019 12:48:09 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, newella@fb.com, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dennisz@fb.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A63F937-F7B5-4D09-9DB4-C73D6F571D50@linaro.org>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614175642.GA657710@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 14 giu 2019, alle ore 19:56, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> On Thu, Jun 13, 2019 at 06:56:10PM -0700, Tejun Heo wrote:
> ...
>> The patchset is also available in the following git branch.
>>=20
>> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git =
review-iow
>=20
> Updated patchset available in the following branch.  Just build fixes
> and cosmetic changes for now.
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git =
review-iow-v2
>=20

Hi Tejun,
I'm running the kernel in your tree above, in an Ubuntu 18.04.

After unmounting the v1 blkio controller that gets mounted at startup
I have created v2 root as follows

$ mount -t cgroup2 none /cgroup

Then I have:
$ ls /cgroup
cgroup.controllers  cgroup.max.descendants  cgroup.stat             =
cgroup.threads  io.weight.cost_model  system.slice
cgroup.max.depth    cgroup.procs            cgroup.subtree_control  =
init.scope      io.weight.qos         user.slice

But the following command gives no output:
$ cat /cgroup/io.weight.qos=20

And, above all,
$ echo 1 > /cgroup/io.weight.qos=20
bash: echo: write error: Invalid argument

No complain in the kernel log.

What am I doing wrong? How can I make the controller work?

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun

