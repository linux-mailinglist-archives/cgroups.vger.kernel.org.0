Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 401BB18094D
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2020 21:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCJUkP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Mar 2020 16:40:15 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:50569 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbgCJUkP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Mar 2020 16:40:15 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 57C2A930;
        Tue, 10 Mar 2020 16:40:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 10 Mar 2020 16:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:cc
        :subject:from:to:message-id; s=fm2; bh=8WvbRILYPoYcT8dxosBEiC8oW
        xw+zHTO76bbxckt8n8=; b=ZTdTsBQqnGlN82GljZ7ESrmeyYE+fTjgey4UhMzpJ
        3N4fMDtH9kyzIGOx7nzUYnSKc7bXucBB8PkuCIq/jwR/fFicp7c1o20WDkFIcL9O
        qax6PFx9BpgRnJgmLcC8T9bfhHyanrIqjCaHZAExqUaNRYiWoM1YLg7Fytzh+FHT
        Y6rUSTgvbrsCTnuGM/vOM5f+6Jh3xYQ4l5fgxQ2ce1bA5XdPxMStWzD+/zZmv/UK
        JHOd23JYCyC3yqwNz+MOXJczPOceZyk93e+7MhjWeQgKmGa1GgwmPVUvO8/54BES
        dhXMJPlxelF1uvg4t1fYU2ypuDHhXw8HTQhoLXEf377Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8WvbRI
        LYPoYcT8dxosBEiC8oWxw+zHTO76bbxckt8n8=; b=QyL8Hee7vDR49szK/qplbo
        DJgRHYUR7BLgBMCqGnNi/yEhTbWK1F/Vxm27DH6xOSTGZ9qBEYoxCcjOJBJaUTVg
        IzNoXjRmOi2WsGj3pKFybI4t6AVpxuCwTA85KAhFFKkCjPn8FR7m6RJmz6swNKJd
        mZgUS1XKDKNK5osuEmg/WeawvyjNGbZqYw0g5qvhMTJxVf0ueop8qfBJn0R6SQTw
        bg8QbkSCePE+YAZx2Vwa+EGoz0OGTG3XFVhgh+t+czA922S9NdxdeJUdnJ5HLRBS
        V0EPPoRtMjQSK1DhY2HRuRwCvbPtjdLtdJ6mVYZzbVwpnGz2lSsu0i8pnxw8JthQ
        ==
X-ME-Sender: <xms:KvtnXgFs-_XVzzMRlvmy1bjTd8Lla2kFeC7DUQIbNVvJSGexithkWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvtddgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepgfgtjgffuffhvffksehtqhertddttdej
    necuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqne
    cukfhppeduieefrdduudegrddufedvrddunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:KvtnXqg1JUtLw_VLSVuqYV3WOOUqv8S4lG7JM09lmiqoSj7eM4ZdKw>
    <xmx:KvtnXqmyp3gH0CR7g6EK0Ti3JvUPxdsA1viCZgxZm6lFmRPCoqi7_g>
    <xmx:KvtnXrdrAshGVQBQe2kkLgNqmg4Ply9P_uKFW9j724oGFheM6DHJZQ>
    <xmx:LftnXnH0hzH8R6XDCjjPQMaFcDr7LXFchhul-4VbrlK0_CZq_AcIjg>
Received: from localhost (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 42A4E328005E;
        Tue, 10 Mar 2020 16:40:09 -0400 (EDT)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Tue Mar 10, 2020 at 12:40 PM
Originalfrom: "Shakeel Butt" <shakeelb@google.com>
Original: =?utf-8?q?Hi_Daniel,
 =0D=0A=0D=0AOn_Thu,_Mar_5,_2020_at_1:16_PM_Daniel_Xu_?=
 =?utf-8?q?<dxu@dxuuu.xyz>_wrote:=0D=0A>=0D=0A>_It's_not_really_necessary_?=
 =?utf-8?q?to_have_contiguous_physical_memory_for_xattr=0D=0A>_values._We_?=
 =?utf-8?q?no_longer_need_to_worry_about_higher_order_allocations=0D=0A>_f?=
 =?utf-8?q?ailing_with_kvmalloc,_especially_because_the_xattr_size_limit_i?=
 =?utf-8?q?s_at=0D=0A>_64K.=0D=0A>=0D=0A>_Signed-off-by:_Daniel_Xu_<dxu@dx?=
 =?utf-8?q?uuu.xyz>=0D=0A=0D=0AThe_patch_looks_fine_to_me._However_the_com?=
 =?utf-8?q?mit_message_is_too_cryptic=0D=0Ai.e._hard_to_get_the_motivation?=
 =?utf-8?q?_behind_the_change.=0D=0A?=
In-Reply-To: <CALvZod62gypsxCYOpGsR6SWwp7roh8eEEKvZ8WNFtjB0bH=okg@mail.gmail.com>
Date:   Tue, 10 Mar 2020 13:40:08 -0700
Cc:     "Cgroups" <cgroups@vger.kernel.org>, "Tejun Heo" <tj@kernel.org>,
        "Li Zefan" <lizefan@huawei.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Kernel Team" <kernel-team@fb.com>
Subject: Re: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Shakeel Butt" <shakeelb@google.com>
Message-Id: <C17G1V88F2XD.EQFO8E8QX1YO@dlxu-fedora-R90QNFJV>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Shakeel,

On Tue Mar 10, 2020 at 12:40 PM, Shakeel Butt wrote:
> Hi Daniel,
>
>=20
> On Thu, Mar 5, 2020 at 1:16 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > It's not really necessary to have contiguous physical memory for xattr
> > values. We no longer need to worry about higher order allocations
> > failing with kvmalloc, especially because the xattr size limit is at
> > 64K.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>
>=20
> The patch looks fine to me. However the commit message is too cryptic
> i.e. hard to get the motivation behind the change.
>

Thanks for taking a look. The real reason I did it was because Tejun
said so :).

Tejun, is there a larger reason?


Thanks,
Daniel
