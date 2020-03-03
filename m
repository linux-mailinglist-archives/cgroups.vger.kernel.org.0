Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0E5178304
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2020 20:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgCCTUi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Mar 2020 14:20:38 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34289 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729960AbgCCTUi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Mar 2020 14:20:38 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3568A21C28;
        Tue,  3 Mar 2020 14:20:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 03 Mar 2020 14:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:cc
        :subject:from:to:message-id; s=fm2; bh=FJ6KELxyo/zYZfyW+0Pn8m70T
        4Tx2JSVTx48BzYMJvg=; b=tkLGfZkSv5J9psMO+WQWVj4I6UVu6g4z0tOr6y64Q
        qasyR5Q7LFNOS3wRB1Fts5bIDy7jD6TnGYbt+QVV3wjIhzY5xzKPydwZGckLaWCv
        iZN3EUeGwRvu65muDaE60yATilaeeEYLUxIvyWCe08GETO4Hp6O0isa1rpaaoM2c
        Gex1JZn7kNhZnmJhCsHFOwzMK2ylg5NgqK50fMt4C+8v9RJ02un+mOtLf+4iB7FZ
        9h08uWg/Kl2rJ5nytZZhT4JXuKH5QGKsfUUw9NsXDYyNcQFEU7Lxr80NWb5kQvyX
        LtT7YAGyMQbu/s5aG881J7UR5CjYgftzAzqPwV/aVyvPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=FJ6KEL
        xyo/zYZfyW+0Pn8m70T4Tx2JSVTx48BzYMJvg=; b=hy/0/NtTPq7PPl0uM4niAG
        Os5W20Gk/M2MwlNSZ/RxvXdWcQEE93Ilam/7BN+uUm4qeFiWW4lpWhCxBhKBWoDC
        b42sPcbuwWU/LLmwGAE2lGmti6noCFUSjjj0ZXNMhtHVgTH8TC723SbGZdagCDMB
        LR22vsFb7I0pumNzENvll+8iJ7thsaUXedFPzRFckiBjpr7LhfYp5q2Fb3tifKKC
        WX5TJNBdxUhaQWozRsKVGFafjtvsXLCr/479LMPQMjG6BCH5wcAD1uKEfDnI2CaD
        EI7T3r0f5iVSi6y5m3cjQZhH4UAH2F2IF2c2iNtr4+v8hMh+mi7BzuZDrn3Wgvvw
        ==
X-ME-Sender: <xms:Aq5eXs4y8Oo8tKuGok_q6Y7347suqQmjWgF9pFJ7j0z5ZMi0UmDrpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddtiedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepgfgtjgffuffhvffksehtqhertddttdej
    necuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqne
    cukfhppeduieefrdduudegrddufedvrddunecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:A65eXqK2Hb_XpapE0xd5An8hIHfWXzAXom1Ts-Kf9-ma66JRWm6A8A>
    <xmx:A65eXlHX_AYZMttRpZLoBG1KBQjbI9sgtxZi2MkMenzHxkIfyAN6og>
    <xmx:A65eXhel5VL5TzvTwbIQfLqUaxUjf4euvPk2ZgdS8EVVJLP4YyCaWQ>
    <xmx:Ba5eXtSfRF4Gy8rfbvHCSs0SWAslArxRiny7qGVQvidDNhD2Bwr5yg>
Received: from localhost (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 589793280060;
        Tue,  3 Mar 2020 14:20:33 -0500 (EST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Tue Mar 3, 2020 at 8:50 AM
Originalfrom: "Shakeel Butt" <shakeelb@google.com>
Original: =?utf-8?q?Hi_Daniel,
 =0D=0A=0D=0AOn_Mon,_Mar_2,_2020_at_5:42_PM_Daniel_Xu_?=
 =?utf-8?q?<dxu@dxuuu.xyz>_wrote:=0D=0A>=0D=0A>_User_extended_attributes_a?=
 =?utf-8?q?re_useful_as_metadata_storage_for_kernfs=0D=0A>_consumers_like_?=
 =?utf-8?q?cgroups._Especially_in_the_case_of_cgroups,_it_is_useful=0D=0A>?=
 =?utf-8?q?_to_have_a_central_metadata_store_that_multiple_processes/servi?=
 =?utf-8?q?ces_can=0D=0A>_use_to_coordinate_actions.=0D=0A>=0D=0A>_A_concr?=
 =?utf-8?q?ete_example_is_for_userspace_out_of_memory_killers._We_want_to?=
 =?utf-8?q?=0D=0A>_let_delegated_cgroup_subtree_owners_(running_as_non-roo?=
 =?utf-8?q?t)_to_be_able_to=0D=0A>_say_"please_avoid_killing_this_cgroup".?=
 =?utf-8?q?_In_server_environments_this_is=0D=0A>_less_important_as_everyo?=
 =?utf-8?q?ne_is_running_as_root.=0D=0A=0D=0AI_would_recommend_removing_th?=
 =?utf-8?q?e_"everyone_is_running_as_root"_statement=0D=0Aas_it_is_not_gen?=
 =?utf-8?q?erally_true.=0D=0A=0D=0AShakeel=0D=0A?=
In-Reply-To: <CALvZod5m3otRRqcLBebbgiZbhoYWAMbMg+ESkacJuj64OP
 =H4Q@mail.gmail.com>
Date:   Tue, 03 Mar 2020 11:20:32 -0800
Cc:     "Cgroups" <cgroups@vger.kernel.org>, "Tejun Heo" <tj@kernel.org>,
        "Li Zefan" <lizefan@huawei.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Kernel Team" <kernel-team@fb.com>
Subject: Re: [PATCH 0/2] Support user xattrs in cgroupfs
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Shakeel Butt" <shakeelb@google.com>
Message-Id: <C11FZ3TMTIH1.2KP5NIUPPQBWT@dlxu-fedora-R90QNFJV>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue Mar 3, 2020 at 8:50 AM, Shakeel Butt wrote:
> Hi Daniel,
>
>=20
> On Mon, Mar 2, 2020 at 5:42 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > User extended attributes are useful as metadata storage for kernfs
> > consumers like cgroups. Especially in the case of cgroups, it is useful
> > to have a central metadata store that multiple processes/services can
> > use to coordinate actions.
> >
> > A concrete example is for userspace out of memory killers. We want to
> > let delegated cgroup subtree owners (running as non-root) to be able to
> > say "please avoid killing this cgroup". In server environments this is
> > less important as everyone is running as root.
>
>=20
> I would recommend removing the "everyone is running as root" statement
> as it is not generally true.
>
>=20
> Shakeel

Good point, thanks.
