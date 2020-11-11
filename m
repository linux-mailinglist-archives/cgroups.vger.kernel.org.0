Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ABE2AF74A
	for <lists+cgroups@lfdr.de>; Wed, 11 Nov 2020 18:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgKKRTw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Nov 2020 12:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbgKKRTw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Nov 2020 12:19:52 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E7AC0613D1
        for <cgroups@vger.kernel.org>; Wed, 11 Nov 2020 09:19:52 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id e8so647383vkk.8
        for <cgroups@vger.kernel.org>; Wed, 11 Nov 2020 09:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UL2wfa/4du6yc1p0RZb5RDC24E3Qw223Z/qO4WPONiM=;
        b=WtHwlLNsnYMylNy+J2/4lWLpxV9knD5GTi6yJAyYRlveqgSJh//i/ZxxOH0ugttQiJ
         EnVHSF7oOol28ppG9eBFVqcAc/cZ1xXzp0ySpleH+x7QQ7T8pis7dnHMJ29QH9lcLQub
         l6iSN4KqjBZxx7H5dtMPxh8IdjpCj8TJ8lqUfsJ0gYAbQQcMoaR5/ork8jS2zHW6KSBV
         9w2oWQ4SkSm+e/Zn5mhoNWPhSUyKifOk2UvHz952zmLLmfneo0aLNwGl5oriNI5Ubf0J
         y41kQG6lD1LN/wBFgYnSj8d7aEsbvGlz0WVSOSpPs2ixmrCzyefDICFZzlsB3WH5kdj9
         5/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UL2wfa/4du6yc1p0RZb5RDC24E3Qw223Z/qO4WPONiM=;
        b=ePRKdWhop+OI650qy3V1jo3flluu2RqAv3hMDmJfiyup16yPCANStataRoeMIcZeid
         H27K8jZo+paLiTNJueDMiwphkwE80dtywOFJVpcTBvzHzumsfBH7BeN5kR+t/dorgJhQ
         rBxO9LNbyH9s5aL+/0p/GWc377bwpUHP65OGXdZdvCpeMXPLkpyTC4GrYpHndkQoq4GZ
         yO0g+s65q44an18Ql1pJ/vln68JI6EqU4PfkQCHLNKNxp+Ua6vUggQi/ScGXPEXsJ0NZ
         xfwZ4MLnO0F9BUfAPMBd8D+z664duhZf0UB8P+v5yyQBM4d1V1EndUkfs+0pvorwFOtr
         AKWA==
X-Gm-Message-State: AOAM533n/1Fhk+4JrfjF8AOHM37+P0L2uPOchF0cvaC/p14kZSLhqmlI
        E1P9FGMO6BTQJMVs+sexWxnMp3ev9zYqPec+axOXHnIMHVE=
X-Google-Smtp-Source: ABdhPJwKxTRftmMIBrmV4Bvg6ZJgNlerWYOHGfSpGgVvTEfY3jUUzDEuvwnSlgyZwpqm/lVhtM+QPCb8DHDxGCoT/Jw=
X-Received: by 2002:a1f:1289:: with SMTP id 131mr14868519vks.24.1605115191398;
 Wed, 11 Nov 2020 09:19:51 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?0JXQvdGM0YjQuNC9INCQ0L3QtNGA0LXQuQ==?= 
        <and.enshin@gmail.com>
Date:   Thu, 12 Nov 2020 02:19:40 +0900
Message-ID: <CAHoi7St=-G_0TYcXiMYjSF0OG1GFc=Bu165hGX4yNW+wDcO=QQ@mail.gmail.com>
Subject: systemd subsystem: exists or not exists ?
To:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi cgroups folks,

I have very simple question which I was not able to google: is there
such subsystem as systemd?

It is not shown in `lssubsys -am` and `cat /proc/cgroups` but shown in
`cat /proc/self/mountinfo`.


Also in some cases I can see how =C2=ABsystemd=C2=BB subsystem, If we can c=
all
it so, breaks Rule 2 described in the Red Hat doc:
=C2=ABAny single subsystem (such as cpu) cannot be attached to more than
one hierarchy if one of those hierarchies has a different subsystem
attached to it already.=C2=BB

Attached two times, if I understand it correctly:
# cat /proc/self/mountinfo | grep systemd | grep cgroup
26 25 0:23 / /sys/fs/cgroup/systemd rw,nosuid,nodev,noexec,relatime
shared:6 - cgroup cgroup
rw,xattr,release_agent=3D/usr/lib/systemd/systemd-cgroups-agent,name=3Dsyst=
emd
2826 26 0:23 /kubepods/burstable/pod7ffde41a-fa85-4b01-8023-69a4e4b50c55/88=
42def241fac72cb34fdce90297b632f098289270fa92ec04643837f5748c15
/sys/fs/cgroup/systemd/kubepods/burstable/pod7ffde41a-fa85-4b01-8023-69a4e4=
b50c55/8842def241fac72cb34fdce90297b632f098289270fa92ec04643837f5748c15
rw,nosuid,nodev,noexec,relatime shared:6 - cgroup cgroup
rw,xattr,release_agent=3D/usr/lib/systemd/systemd-cgroups-agent,name=3Dsyst=
emd

So, to cocnlude
Q1. Is there such subsystem as systemd?
Q2. Why it=E2=80=99s not shown in one way but shown in another?
Q3. Why I can see it is mounted twice breaking Rule 2?

--=20

Best Regards,
Andrei Enshin
