Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF010A4A6
	for <lists+cgroups@lfdr.de>; Tue, 26 Nov 2019 20:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfKZTlO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Nov 2019 14:41:14 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46356 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfKZTlN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Nov 2019 14:41:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id n23so16937439otr.13
        for <cgroups@vger.kernel.org>; Tue, 26 Nov 2019 11:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsKgJ5qFUgopMwvxZ4JDss58rF+rfZraBDg650+0Z0Y=;
        b=cD48sxrRbKVlxTAah5kCzM2yI7ff2DNlrMEWuGGZnBU8q+RiOKqgBtEh8xGcZInqwP
         Mz24ezGC4SLLRM+Qc0MQjE/pe4SitwcZLSg7TBXw8NiDMC8u1uySoNkVIhjWBhqsxaIJ
         zEa/EHupUKo7CpdUaJtLcTm5A9g5GmFcDeVVi6iBuvCchC60HAKvMpSxs5LLmP9rXMtg
         34Dou4f2XbYa2NXWVz1VBPwJf7Ge5UmLMI0ILuIn4udXYq+B8GpT5UbHf1BsvDJ7MKMg
         8VKSpzzoTp5fOQ//mEiATTmtUDdk6hy7u/hAOG3NdFJSa3u0X33LQpCRPnjcW64DPtLe
         eISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsKgJ5qFUgopMwvxZ4JDss58rF+rfZraBDg650+0Z0Y=;
        b=sFxZx6c57Vfc6xUckVg+Bn/OqfU0Qhkzi6IWZkzaYfAiqKvTfLSNWn1OgPyciSDwTG
         NP4aWp1gcOTQoTMmUGW6T9lXKaBG1GPaXD7KFjLGjvQ07bV5Iy3Dqo1Hf2/rfi02rC9F
         VgiJxwmeDs/DydqBYBWoKAM7Jx/zPV99Z9mMvRZN465Fd8VO2nOk7YtdSyyNSiOVk1+4
         hEwpfaDTneCjkFvsSD76ufsYFvzMAtDQ2TlEJV9A5YD3ry+4pghPjMzSg4krlviSjgaB
         R9N3Gi2JNGcAYmvY1puugdfTNcwibT0WsRU6U1FgdXqw7nW5Ju0fNeNIBvvN2vYYQORw
         5g8Q==
X-Gm-Message-State: APjAAAXPAi03RjAx07M4KFAZC2Um7Ef8ixFEJd/x9yxStE03DXfoIn0O
        /3sGAKqw4k+hD6h4Te2h/q2bz08XCfn+uZ8YlWDtW7AE
X-Google-Smtp-Source: APXvYqwbkhqIofEOqkKbby5QEzvf0MywPslDzhs8RQTrL1thmB2MW98GdBPgEDIlEnhuS97UTMDdNg8PAGZkvEIz54g=
X-Received: by 2002:a9d:6649:: with SMTP id q9mr513560otm.313.1574797272502;
 Tue, 26 Nov 2019 11:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20191121211424.263622-1-gscrivan@redhat.com> <CAHS8izPwEFbdtNrDT-xfPs9Zc1YoAY5hmDH0j3fbRZE-OjneuQ@mail.gmail.com>
 <87tv6wmgv3.fsf@redhat.com>
In-Reply-To: <87tv6wmgv3.fsf@redhat.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 26 Nov 2019 11:41:01 -0800
Message-ID: <CAHS8izPzEpts+opkfLP-zjJoNzb1VByQ1KSqSM7GnWBXgKXASg@mail.gmail.com>
Subject: Re: [PATCH] mm: hugetlb controller for cgroups v2
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     cgroups@vger.kernel.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 22, 2019 at 12:54 AM Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Hi Mina,
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > On Thu, Nov 21, 2019 at 1:14 PM Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> >>
> >> In the effort of supporting cgroups v2 into Kubernetes, I stumped on
> >> the lack of the hugetlb controller.
> >>
> >> When the controller is enabled, it exposes three new files for each
> >> hugetlb size on non-root cgroups:
> >>
> >> - hugetlb.<hugepagesize>.current
> >> - hugetlb.<hugepagesize>.max
> >> - hugetlb.<hugepagesize>.stat
> >>
> >> The differences with the legacy hierarchy are in the file names and
> >> using the value "max" instead of "-1" to disable a limit.
> >>
> >> The file .limit_in_bytes is renamed to .max.
> >>
> >> The file .usage_in_bytes is renamed to .usage.
> >>
> >
> > I could be wrong here but I think the memcg files are not renamed, so
> > the same file names exist in v1 and v2. Can we follow that example?
>
> I've enabled all the controllers, but I don't see files under
> /sys/fs/cgroup that have the .limit_in_bytes or .usage_in_bytes suffix.
>
> To what files are you referring to?

Never mind, I was wrong. The limit_in_bytes and usage_in_bytes are
indeed renamed in the memcg in v2. Please ignore :)

>
> Thanks,
> Giuseppe
>
