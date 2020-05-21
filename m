Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7BB1DCA2F
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 11:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgEUJgJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 05:36:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbgEUJgJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 05:36:09 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MV6G6-1jRDmr065O-00S4aI; Thu, 21 May 2020 11:36:07 +0200
Received: by mail-qk1-f173.google.com with SMTP id i5so6503277qkl.12;
        Thu, 21 May 2020 02:36:06 -0700 (PDT)
X-Gm-Message-State: AOAM532tdMBB+TVbWUDVaovW3ZoNwPPp2cTaOQb2mN7sPzfXEmx4BiXR
        GgjYShL6CoZQ5QinJKjs1vpCXMpI5JDoMeLVM2g=
X-Google-Smtp-Source: ABdhPJws3KKBV0w5Mhpfv6LZKBqE10KcRtqFB/QC1e+qfkRLL99VkSqd9yoBmueLGwUSMY9q0aWGCr2HfWe2EBzpd8M=
X-Received: by 2002:a37:4c48:: with SMTP id z69mr8052116qka.138.1590053765528;
 Thu, 21 May 2020 02:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz> <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz> <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name> <CA+G9fYt1qvGQTAdUZ4WgitY18cydgnNzqu_fyoTtSm3W8JhF3w@mail.gmail.com>
In-Reply-To: <CA+G9fYt1qvGQTAdUZ4WgitY18cydgnNzqu_fyoTtSm3W8JhF3w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 May 2020 11:35:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Yna-BD+M6-+Y2Go_Y0ZXx8_7KMud7JxSfPbG8+-Q7Wg@mail.gmail.com>
Message-ID: <CAK8P3a2Yna-BD+M6-+Y2Go_Y0ZXx8_7KMud7JxSfPbG8+-Q7Wg@mail.gmail.com>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:tE3t4TPrND4BHXRl6VrQxpilryG1scFRiFa8boVDA7y+3W+2ulA
 m2PT/hqzBoz12kmiz7J4oY82+0aCSbQNFLtsRcYQZB+iqmF6pSeD8QWhVY+RBR16+NPuPFf
 ZRRyL1B8qNZPMS305xGjd83w6fkA1IE3/u5IkvUuBOFpfmor7KQd2JnqxSSd5JjnyoIBk9U
 zMLRHViqkSxwTi7mJGC+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8dbZaZ6lhT0=:b/ekQTZHioS9KkLCYnPh5N
 uvR3WiOuz3VGP99yC0Nf+Vk3FYp9XjDuwgshHynI+bM1U52lhJOfUi1EY0AwQSZFSZCe/P/Vw
 3syZlZY6O5XFZtaOId7tPJvDeJYZQ6EHN/1nMuCiqPbh5smnbEIua9Wfo6xT2FlJkn7FiQNIl
 5dr8yKWy0FvagBahaGvPmKpB6vgWq0jGru2pnjXlnRz0ShozTmFE592aHfUjqDbqcfTdOwRGL
 5i6uYo4pQRdZNV/E7gjv1y1Rqo86XS71NncoYSBP2AzkqgIoCzEYGnNBS6kkgc79QwfPvmscv
 pfR7KPTay4Asb7A6lyrvugMb8BC1B6EsSal+lCN//cA0tfJG4KoJL0esSEobTji0BzI44XNhm
 3fcUrSfGI5tE/reO9Pb5dSEkAmxykMv1iAlcuu0qNvWjPG7lRpWvlyzq2pt0zs5RYggG2Wax/
 QSoSc0UZxC6bBC2GPl2W8rbqaoQBcuxD6tzZMVvXcNYBSybvu32id6xKegatZr05f+u9doJY0
 pUgJobQc5Kd6cZQT4bde5HIJOxBQ7zWH3AxTiLlop8MA0io31hYqMLZuTx1w5AA32qtnBl+0C
 Kd8drNOv+NP8vio1rz8hUt3uJU/TOMSrPvm2ON3X7rnmlNh3KavnimntNPFuazcTbcgfltREQ
 BypiaNyCEz6GY7PY/zdx4wfAorTrFmB8ShtpdX37hW0KK2hkZzhNVt3B5FUVCqDOrKradH8mq
 atkX9MDemwiNjDUeGvxESYEoSV3e3v8rmM8DP1wHcRHApcaSdFgeOQAZQPjesbTKQa7cMd684
 os953vEyKqhkGO9869LJzt/v427XuK0Q7w6Wh0cWxB1hgQdjoo=
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 21, 2020 at 11:22 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
> On Thu, 21 May 2020 at 00:39, Chris Down <chris@chrisdown.name> wrote:
> > Since you have i386 hardware available, and I don't, could you please apply
> > only "avoid stale protection" again and check if it only happens with that
> > commit, or requires both? That would help narrow down the suspects.

Note that Naresh is running an i386 kernel on regular 64-bit hardware that
most people have access to.

> kernel config link,
> https://builds.tuxbuild.com/8lg6WQibcwtQRRtIa0bcFA/kernel.config

Do you know if the same bug shows up running a kernel with that
configuration in qemu? I would expect it to, and that would make
it much easier to reproduce.

I would also not be surprised if it happens on all architectures but only
shows up on the 32-bit arm and x86 machines first because they have
a rather limited amount of lowmem. Maybe booting a 64-bit kernel
with "mem=512M" and then running "dd if=/dev/sda of=/dev/null bs=1M"
will also trigger it. I did not attempt to run this myself.

       Arnd
