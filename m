Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9FC703F2D
	for <lists+cgroups@lfdr.de>; Mon, 15 May 2023 23:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240909AbjEOVBo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 May 2023 17:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245247AbjEOVBh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 May 2023 17:01:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD697D2EE
        for <cgroups@vger.kernel.org>; Mon, 15 May 2023 14:01:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b51eso61766845e9.2
        for <cgroups@vger.kernel.org>; Mon, 15 May 2023 14:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684184484; x=1686776484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i9XXekhocWRvRTQ2M3xQOXHtCAkTtEc1Jdp5Ijy8GI=;
        b=TgMOwNKjafPRWuxjVw+ia+qAFxXEDjeEM+Bb9tgsloPRfCWa+mRwdTD902B+aR38J6
         sS2czZF8vradcjfv3OXN9DeSUeMvp2SSYLpxmN4WbqFdsuVKPbASyS8I8RFT8kjHP+4x
         iqhOzjkyFk1Ha7PV5eT0Zphqx0Q7jMyHwDxBZaKO3dzbL3lr2C3yKtqOWxRuFVn04etV
         PpYWMwGeIQVrljYZgVNrqJk/xwgdnIaysQcXWmip2Ryb6mxzEU9wZNJ6YSqz6nGZ/FsY
         VdIgN9f3JXhVC5IAeb1f5HcKMv8j1MtII92pTmIV6b+3AMU9k3zPi5WLb7C76Pf7Li/S
         9Wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684184484; x=1686776484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1i9XXekhocWRvRTQ2M3xQOXHtCAkTtEc1Jdp5Ijy8GI=;
        b=CG5IldUyEaZq3snLfvQwiPf0v4zEEcdqXhYchrbUhzFwibmE4j3JKS2gnP4+PGRcqK
         zNKfJPGkz+0uX/iUMqua4d6SlWzw754fG3z1ERJezSEcNEL5R9gpWPreEyBe7VtemjN0
         ki28Sy6xjUiSJM9UWQ6n8XDYyEvNfgc5zh6zYgU9MWUq2KScMtE7JcgPf5sIzn2inaC/
         KydbyQtBlu1r86xXr3B2FnDHEZ1U1ebMQUIohv6+15lO4zDmk7iLRM58/jEPrEUb78Iq
         q8D/8vyV86MLwQ+YZLEhTg+1i/yGNEzcLDpXq1ZiRf4IWAu0qiUJ4wWWZxhIjFonr2mg
         3zfg==
X-Gm-Message-State: AC+VfDzkxieS4dPohQ0yZ+mueVnHB+CPMmn9W9XmcoJSEJlk72Gr7fB5
        6EYNhszcOyutzPq09egMaqXXwyDL/90Y9ckw/T5JLA==
X-Google-Smtp-Source: ACHHUZ7f8vo0LJtLR6lF3rT5LGAOC2H2n/EKZxUSh+S9e1DvMI2OJsX3bxSOAwd5qM36BJBSwCIZoFOqCP15wVIA9Tw=
X-Received: by 2002:a7b:c8d4:0:b0:3f4:447d:f74a with SMTP id
 f20-20020a7bc8d4000000b003f4447df74amr15545704wml.26.1684184483885; Mon, 15
 May 2023 14:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230509185419.1088297-1-yuanchu@google.com> <20230509185419.1088297-3-yuanchu@google.com>
In-Reply-To: <20230509185419.1088297-3-yuanchu@google.com>
From:   "T.J. Alumbaugh" <talumbau@google.com>
Date:   Mon, 15 May 2023 15:00:47 -0600
Message-ID: <CABmGT5GARdTGN+EgNvXHqR2tLD2X-BeNy5gAhTPVdi700+C2Og@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] virtio-balloon: Add Working Set reporting
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Sudarshan Rajagopalan (QUIC)" <quic_sudaraja@quicinc.com>,
        kai.huang@intel.com, hch@lst.de, jon@nutanix.com,
        SeongJae Park <sj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For completeness, the corresponding QEMU device change is here:

https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02503.html

and the proposed VIRTIO spec change is here:

https://lists.oasis-open.org/archives/virtio-comment/202305/msg00227.html

I think some of the more fundamental questions about the driver change
might be best handled on virtio-comment and/or virtio-dev. Thanks,

-T.J.


On Tue, May 9, 2023 at 12:54=E2=80=AFPM Yuanchu Xie <yuanchu@google.com> wr=
ote:
>
> From: talumbau <talumbau@google.com>
>
>  - Add WS and notification vqueues
>  - Add simple interface to kernel WS functions
>  - Driver receives config info and sends reports on notification
>  - use mutex to guard virtio_balloon state
>
> Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 243 +++++++++++++++++++++++++++-
>  include/linux/balloon_compaction.h  |   6 +
>  include/uapi/linux/virtio_balloon.h |  21 +++
>  mm/vmscan.c                         | 102 ++++++++++++
>  4 files changed, 371 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 3f78a3a1eb75..edfa2a4960a3 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -11,6 +11,7 @@
>  #include <linux/swap.h>
>  #include <linux/workqueue.h>
>  #include <linux/delay.h>
> +#include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/balloon_compaction.h>
> @@ -39,12 +40,22 @@
>         (1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
>  #define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON_HINT_BLOCK_=
ORDER)
>
> +/* TODO: replace with a registration interface, similar to shrinker regi=
stration. */
> +extern int register_wss_receiver(void *receiver, struct pglist_data *pgd=
at,
> +                               unsigned long *intervals, unsigned long n=
r_bins,
> +                               unsigned long report_threshold,
> +                               unsigned long refresh_threshold);
> +extern void unregister_wss_receiver(void *receiver);
> +extern bool working_set_request(struct pglist_data *pgdat);
> +
>  enum virtio_balloon_vq {
>         VIRTIO_BALLOON_VQ_INFLATE,
>         VIRTIO_BALLOON_VQ_DEFLATE,
>         VIRTIO_BALLOON_VQ_STATS,
>         VIRTIO_BALLOON_VQ_FREE_PAGE,
>         VIRTIO_BALLOON_VQ_REPORTING,
> +       VIRTIO_BALLOON_VQ_WS,
> +       VIRTIO_BALLOON_VQ_NOTIFY,
>         VIRTIO_BALLOON_VQ_MAX
>  };
>
> @@ -54,7 +65,8 @@ enum virtio_balloon_config_read {
>
>  struct virtio_balloon {
>         struct virtio_device *vdev;
> -       struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_=
vq;
> +       struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_=
vq,
> +               *ws_vq, *notification_vq;
>
>         /* Balloon's own wq for cpu-intensive work items */
>         struct workqueue_struct *balloon_wq;
> @@ -64,6 +76,8 @@ struct virtio_balloon {
>         /* The balloon servicing is delegated to a freezable workqueue. *=
/
>         struct work_struct update_balloon_stats_work;
>         struct work_struct update_balloon_size_work;
> +       struct work_struct update_balloon_ws_work;
> +       struct work_struct update_balloon_notification_work;
>
>         /* Prevent updating balloon when it is being canceled. */
>         spinlock_t stop_update_lock;
> @@ -110,6 +124,10 @@ struct virtio_balloon {
>         /* Memory statistics */
>         struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
>
> +       /* A buffer to hold incoming notification from the host. */
> +       unsigned int notification_size;
> +       void *notification_buf;
> +
>         /* Shrinker to return free pages - VIRTIO_BALLOON_F_FREE_PAGE_HIN=
T */
>         struct shrinker shrinker;
>
> @@ -119,6 +137,10 @@ struct virtio_balloon {
>         /* Free page reporting device */
>         struct virtqueue *reporting_vq;
>         struct page_reporting_dev_info pr_dev_info;
> +
> +       /* Working Set reporting */
> +       u32 ws_num_bins;
> +       struct virtio_balloon_ws *ws;
>  };
>
>  static const struct virtio_device_id id_table[] =3D {
> @@ -301,6 +323,41 @@ static unsigned int leak_balloon(struct virtio_ballo=
on *vb, size_t num)
>         return num_freed_pages;
>  }
>
> +/* Must hold the balloon_lock while calling this function. */
> +static inline void reset_working_set(struct virtio_balloon *vb)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < vb->ws_num_bins; ++i) {
> +               vb->ws[i].tag =3D cpu_to_virtio16(vb->vdev, 0);
> +               vb->ws[i].node_id =3D cpu_to_virtio16(vb->vdev, -1);
> +               vb->ws[i].idle_age_ms =3D cpu_to_virtio64(vb->vdev, 0);
> +               vb->ws[i].memory_size_bytes[0] =3D cpu_to_virtio64(vb->vd=
ev, -1);
> +               vb->ws[i].memory_size_bytes[1] =3D cpu_to_virtio64(vb->vd=
ev, -1);
> +       }
> +}
> +
> +/* Must hold the balloon_lock while calling this function. */
> +static inline void update_working_set(struct virtio_balloon *vb, int idx=
,
> +                              u64 idle_age, u64 bytes_anon,
> +                              u64 bytes_file)
> +{
> +       vb->ws[idx].tag =3D cpu_to_virtio16(vb->vdev, 0);
> +       vb->ws[idx].node_id =3D cpu_to_virtio16(vb->vdev, -1);
> +       vb->ws[idx].idle_age_ms =3D cpu_to_virtio64(vb->vdev, idle_age);
> +       vb->ws[idx].memory_size_bytes[0] =3D cpu_to_virtio64(vb->vdev,
> +            bytes_anon);
> +       vb->ws[idx].memory_size_bytes[1] =3D cpu_to_virtio64(vb->vdev,
> +            bytes_file);
> +}
> +
> +static bool working_set_is_init(struct virtio_balloon *vb)
> +{
> +       if (vb->ws[0].idle_age_ms > 0)
> +               return true;
> +       return false;
> +}
> +
>  static inline void update_stat(struct virtio_balloon *vb, int idx,
>                                u16 tag, u64 val)
>  {
> @@ -386,6 +443,16 @@ static void stats_handle_request(struct virtio_ballo=
on *vb)
>         virtqueue_kick(vq);
>  }
>
> +static void notification_receive(struct virtqueue *vq)
> +{
> +       struct virtio_balloon *vb =3D vq->vdev->priv;
> +
> +       spin_lock(&vb->stop_update_lock);
> +       if (!vb->stop_update)
> +               queue_work(system_freezable_wq, &vb->update_balloon_notif=
ication_work);
> +       spin_unlock(&vb->stop_update_lock);
> +}
> +
>  static inline s64 towards_target(struct virtio_balloon *vb)
>  {
>         s64 target;
> @@ -465,6 +532,130 @@ static void update_balloon_stats_func(struct work_s=
truct *work)
>         stats_handle_request(vb);
>  }
>
> +static int virtio_balloon_register_wss_receiver(struct virtio_balloon *v=
b,
> +       __virtio64 *intervals, unsigned long nr_bins, __virtio64 refresh_=
ms,
> +       __virtio64 report_ms)
> +{
> +       struct pglist_data *pgdat;
> +       unsigned long *bin_intervals =3D NULL;
> +       int i, err;
> +
> +       if (intervals && nr_bins) {
> +               /* TODO: keep values as 32-bits throughout. */
> +               bin_intervals =3D kzalloc(sizeof(unsigned long) * (nr_bin=
s-1),
> +                       GFP_KERNEL);
> +               for (i =3D 0; i < nr_bins - 1; i++)
> +                       bin_intervals[i] =3D (unsigned long)intervals[i];
> +               pgdat =3D NODE_DATA(NUMA_NO_NODE);
> +               err =3D register_wss_receiver(vb, pgdat, &(bin_intervals[=
0]),
> +                       nr_bins, (unsigned long) refresh_ms,
> +                       (unsigned long) report_ms);
> +               kfree(bin_intervals);
> +               return err;
> +       }
> +       return -EINVAL;
> +}
> +
> +void working_set_notify(void *wss_receiver, struct wss_bin *bins)
> +{
> +       u64 bytes_nr_file, bytes_nr_anon;
> +       struct virtio_balloon *vb =3D wss_receiver;
> +       int idx =3D 0;
> +
> +       if (!mutex_trylock(&vb->balloon_lock))
> +               return;
> +       for (; idx < vb->ws_num_bins; idx++) {
> +               bytes_nr_anon =3D (u64)(bins[idx].nr_pages[0]) * PAGE_SIZ=
E;
> +               bytes_nr_file =3D (u64)(bins[idx].nr_pages[1]) * PAGE_SIZ=
E;
> +               update_working_set(vb, idx, jiffies_to_msecs(bins[idx].id=
le_age),
> +                       bytes_nr_anon, bytes_nr_file);
> +       }
> +       mutex_unlock(&vb->balloon_lock);
> +       /* Send the working set report to the device. */
> +       spin_lock(&vb->stop_update_lock);
> +       if (!vb->stop_update)
> +               queue_work(system_freezable_wq, &vb->update_balloon_ws_wo=
rk);
> +       spin_unlock(&vb->stop_update_lock);
> +}
> +
> +EXPORT_SYMBOL(working_set_notify);
> +
> +static void update_balloon_notification_func(struct work_struct *work)
> +{
> +       struct virtio_balloon *vb;
> +       struct scatterlist sg_in;
> +       struct pglist_data *pgdat;
> +       __virtio64 *bin_intervals;
> +       __virtio64 refresh_ms, report_ms;
> +       int16_t tag;
> +       char *buf;
> +       int len;
> +
> +       vb =3D container_of(work, struct virtio_balloon,
> +                         update_balloon_notification_work);
> +
> +       /* Read a Working Set notification from the device. */
> +       buf =3D (char *)vb->notification_buf;
> +       tag =3D *((int16_t *)buf);
> +       buf +=3D sizeof(int16_t);
> +       if (tag =3D=3D VIRTIO_BALLOON_WS_REQUEST) {
> +               pgdat =3D NODE_DATA(NUMA_NO_NODE);
> +               working_set_request(pgdat);
> +       } else if (tag =3D=3D VIRTIO_BALLOON_WS_CONFIG) {
> +               mutex_lock(&vb->balloon_lock);
> +               reset_working_set(vb);
> +               mutex_unlock(&vb->balloon_lock);
> +               bin_intervals =3D (__virtio64 *) buf;
> +               buf +=3D sizeof(__virtio64) * (vb->ws_num_bins - 1);
> +               refresh_ms =3D *((__virtio64 *) buf);
> +               buf +=3D sizeof(__virtio64);
> +               report_ms =3D *((__virtio64 *) buf);
> +               virtio_balloon_register_wss_receiver(vb, bin_intervals, v=
b->ws_num_bins,
> +                       refresh_ms, report_ms);
> +       } else {
> +               dev_warn(&vb->vdev->dev, "Received invalid notification, =
%u\n", tag);
> +               return;
> +       }
> +
> +       /* Detach all the used buffers from the vq */
> +       while (virtqueue_get_buf(vb->notification_vq, &len))
> +               ;
> +       /* Add a new notification buffer for device to fill. */
> +       sg_init_one(&sg_in, vb->notification_buf, vb->notification_size);
> +       virtqueue_add_inbuf(vb->notification_vq, &sg_in, 1, vb, GFP_KERNE=
L);
> +       virtqueue_kick(vb->notification_vq);
> +}
> +
> +static void update_balloon_ws_func(struct work_struct *work)
> +{
> +       struct virtio_balloon *vb;
> +       struct scatterlist sg_out;
> +       int err =3D 0;
> +       int unused;
> +
> +       vb =3D container_of(work, struct virtio_balloon,
> +                         update_balloon_ws_work);
> +
> +       mutex_lock(&vb->balloon_lock);
> +       if (working_set_is_init(vb)) {
> +               /* Detach all the used buffers from the vq */
> +               while (virtqueue_get_buf(vb->ws_vq, &unused))
> +                       ;
> +               sg_init_one(&sg_out, vb->ws, sizeof(struct virtio_balloon=
_ws) * vb->ws_num_bins);
> +               err =3D virtqueue_add_outbuf(vb->ws_vq, &sg_out, 1, vb, G=
FP_KERNEL);
> +       } else {
> +               dev_warn(&vb->vdev->dev, "Working Set not initialized.");
> +               err =3D -EINVAL;
> +       }
> +       mutex_unlock(&vb->balloon_lock);
> +       if (unlikely(err)) {
> +               dev_err(&vb->vdev->dev,
> +                       "Failed to send working set report err =3D %d\n",=
 err);
> +       } else {
> +               virtqueue_kick(vb->ws_vq);
> +       }
> +}
> +
>  static void update_balloon_size_func(struct work_struct *work)
>  {
>         struct virtio_balloon *vb;
> @@ -508,6 +699,10 @@ static int init_vqs(struct virtio_balloon *vb)
>         callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D NULL;
>         names[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D NULL;
>         names[VIRTIO_BALLOON_VQ_REPORTING] =3D NULL;
> +       callbacks[VIRTIO_BALLOON_VQ_WS] =3D NULL;
> +       names[VIRTIO_BALLOON_VQ_WS] =3D NULL;
> +       callbacks[VIRTIO_BALLOON_VQ_NOTIFY] =3D NULL;
> +       names[VIRTIO_BALLOON_VQ_NOTIFY] =3D NULL;
>
>         if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>                 names[VIRTIO_BALLOON_VQ_STATS] =3D "stats";
> @@ -524,6 +719,13 @@ static int init_vqs(struct virtio_balloon *vb)
>                 callbacks[VIRTIO_BALLOON_VQ_REPORTING] =3D balloon_ack;
>         }
>
> +       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING)) =
{
> +               names[VIRTIO_BALLOON_VQ_WS] =3D "ws";
> +               callbacks[VIRTIO_BALLOON_VQ_WS] =3D NULL;
> +               names[VIRTIO_BALLOON_VQ_NOTIFY] =3D "notify";
> +               callbacks[VIRTIO_BALLOON_VQ_NOTIFY] =3D notification_rece=
ive;
> +       }
> +
>         err =3D virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
>                               callbacks, names, NULL);
>         if (err)
> @@ -534,6 +736,7 @@ static int init_vqs(struct virtio_balloon *vb)
>         if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>                 struct scatterlist sg;
>                 unsigned int num_stats;
> +
>                 vb->stats_vq =3D vqs[VIRTIO_BALLOON_VQ_STATS];
>
>                 /*
> @@ -553,6 +756,23 @@ static int init_vqs(struct virtio_balloon *vb)
>                 virtqueue_kick(vb->stats_vq);
>         }
>
> +       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING)) =
{
> +               struct scatterlist sg;
> +
> +               vb->ws_vq =3D vqs[VIRTIO_BALLOON_VQ_WS];
> +               vb->notification_vq =3D vqs[VIRTIO_BALLOON_VQ_NOTIFY];
> +
> +               /* Prime the notification virtqueue for the device to fil=
l.*/
> +               sg_init_one(&sg, vb->notification_buf, vb->notification_s=
ize);
> +               err =3D virtqueue_add_inbuf(vb->notification_vq, &sg, 1, =
vb, GFP_KERNEL);
> +               if (unlikely(err)) {
> +                       dev_err(&vb->vdev->dev,
> +                               "Failed to prepare notifications, err =3D=
 %d\n", err);
> +               } else {
> +                       virtqueue_kick(vb->notification_vq);
> +               }
> +       }
> +
>         if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)=
)
>                 vb->free_page_vq =3D vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
>
> @@ -878,6 +1098,8 @@ static int virtballoon_probe(struct virtio_device *v=
dev)
>
>         INIT_WORK(&vb->update_balloon_stats_work, update_balloon_stats_fu=
nc);
>         INIT_WORK(&vb->update_balloon_size_work, update_balloon_size_func=
);
> +       INIT_WORK(&vb->update_balloon_ws_work, update_balloon_ws_func);
> +       INIT_WORK(&vb->update_balloon_notification_work, update_balloon_n=
otification_func);
>         spin_lock_init(&vb->stop_update_lock);
>         mutex_init(&vb->balloon_lock);
>         init_waitqueue_head(&vb->acked);
> @@ -885,6 +1107,20 @@ static int virtballoon_probe(struct virtio_device *=
vdev)
>
>         balloon_devinfo_init(&vb->vb_dev_info);
>
> +       if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_WS_REPORTING)) {
> +               virtio_cread_le(vdev, struct virtio_balloon_config, ws_nu=
m_bins,
> +                               &vb->ws_num_bins);
> +               /* Allocate space for a Working Set report. */
> +               vb->ws =3D kcalloc(vb->ws_num_bins,
> +                                sizeof(struct virtio_balloon_ws), GFP_KE=
RNEL);
> +               /* Allocate space for host notifications. */
> +               vb->notification_size =3D
> +                       sizeof(uint16_t) +
> +                       sizeof(uint64_t) * (vb->ws_num_bins + 1);
> +               vb->notification_buf =3D kzalloc(vb->notification_size, G=
FP_KERNEL);
> +               reset_working_set(vb);
> +       }
> +
>         err =3D init_vqs(vb);
>         if (err)
>                 goto out_free_vb;
> @@ -1034,11 +1270,15 @@ static void virtballoon_remove(struct virtio_devi=
ce *vdev)
>                 unregister_oom_notifier(&vb->oom_nb);
>         if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)=
)
>                 virtio_balloon_unregister_shrinker(vb);
> +       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING))
> +               unregister_wss_receiver(vb);
>         spin_lock_irq(&vb->stop_update_lock);
>         vb->stop_update =3D true;
>         spin_unlock_irq(&vb->stop_update_lock);
>         cancel_work_sync(&vb->update_balloon_size_work);
>         cancel_work_sync(&vb->update_balloon_stats_work);
> +       cancel_work_sync(&vb->update_balloon_ws_work);
> +       cancel_work_sync(&vb->update_balloon_notification_work);
>
>         if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>                 cancel_work_sync(&vb->report_free_page_work);
> @@ -1104,6 +1344,7 @@ static unsigned int features[] =3D {
>         VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>         VIRTIO_BALLOON_F_PAGE_POISON,
>         VIRTIO_BALLOON_F_REPORTING,
> +       VIRTIO_BALLOON_F_WS_REPORTING,
>  };
>
>  static struct virtio_driver virtio_balloon_driver =3D {
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_c=
ompaction.h
> index 5ca2d5699620..2cf4fca6e7f1 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -43,6 +43,7 @@
>  #include <linux/err.h>
>  #include <linux/fs.h>
>  #include <linux/list.h>
> +#include <linux/mmzone.h>
>
>  /*
>   * Balloon device information descriptor.
> @@ -67,6 +68,11 @@ extern size_t balloon_page_list_enqueue(struct balloon=
_dev_info *b_dev_info,
>                                       struct list_head *pages);
>  extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_i=
nfo,
>                                      struct list_head *pages, size_t n_re=
q_pages);
> +/*
> + * Function to send the working set to a receiver (e.g. the balloon driv=
er)
> + * TODO: Replace with a proper registration interface, similar to shrink=
ers.
> + */
> +extern void working_set_notify(void *wss_receiver, struct wss_bin *bins)=
;
>
>  static inline void balloon_devinfo_init(struct balloon_dev_info *balloon=
)
>  {
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/vir=
tio_balloon.h
> index ddaa45e723c4..06d0683d8d8c 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -37,6 +37,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT        3 /* VQ to report free pa=
ges */
>  #define VIRTIO_BALLOON_F_PAGE_POISON   4 /* Guest is using page poisonin=
g */
>  #define VIRTIO_BALLOON_F_REPORTING     5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_WS_REPORTING 6 /* Working Set Size reporting */
>
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -59,6 +60,8 @@ struct virtio_balloon_config {
>         };
>         /* Stores PAGE_POISON if page poisoning is in use */
>         __le32 poison_val;
> +       /* Number of bins for Working Set report if in use. */
> +       __le32 ws_num_bins;
>  };
>
>  #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> @@ -116,4 +119,22 @@ struct virtio_balloon_stat {
>         __virtio64 val;
>  } __attribute__((packed));
>
> +enum virtio_balloon_ws_op {
> +       VIRTIO_BALLOON_WS_REQUEST =3D 1,
> +       VIRTIO_BALLOON_WS_CONFIG =3D 2,
> +};
> +
> +struct virtio_balloon_ws {
> +#define VIRTIO_BALLOON_WS_RECLAIMABLE 0
> +#define VIRTIO_BALLOON_WS_DISCARDABLE 1
> +       /* TODO: Provide additional detail on memory, e.g. reclaimable. *=
/
> +       __virtio16 tag;
> +       /* TODO: Support per-NUMA node reports. */
> +       __virtio16 node_id;
> +       uint8_t reserved[4];
> +       __virtio64 idle_age_ms;
> +       /* Track separately for ANON_AND_FILE. */
> +       __virtio64 memory_size_bytes[2];
> +};
> +
>  #endif /* _LINUX_VIRTIO_BALLOON_H */
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b3adf924691c..ab343974de91 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -209,6 +209,8 @@ static void set_task_reclaim_state(struct task_struct=
 *task,
>  LIST_HEAD(shrinker_list);
>  DECLARE_RWSEM(shrinker_rwsem);
>
> +static void *wss_receiver;
> +
>  #ifdef CONFIG_MEMCG
>  static int shrinker_nr_max;
>
> @@ -621,6 +623,54 @@ static unsigned long lruvec_lru_size(struct lruvec *=
lruvec, enum lru_list lru,
>         return size;
>  }
>
> +/*
> + * Register/unregister a receiver of wss notifications
> + * TODO: Replace with a proper registration interface, similar to shrink=
ers.
> + */
> +int register_wss_receiver(void *receiver, struct pglist_data *pgdat,
> +                       unsigned long *intervals, unsigned long nr_bins,
> +                       unsigned long refresh_threshold,
> +                       unsigned long report_threshold)
> +{
> +       struct wss *wss;
> +       struct wss_bin *bins;
> +       int i;
> +
> +       wss_receiver =3D receiver;
> +
> +       if (!pgdat)
> +               return 0;
> +
> +       if (!intervals || !nr_bins)
> +               return 0;
> +
> +       bins =3D kzalloc(sizeof(wss->bins), GFP_KERNEL);
> +       if (!bins)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < nr_bins - 1; i++) {
> +               bins[i].idle_age =3D msecs_to_jiffies(*intervals);
> +               intervals++;
> +       }
> +       bins[i].idle_age =3D -1;
> +
> +       wss =3D lruvec_wss(mem_cgroup_lruvec(NULL, pgdat));
> +
> +       mutex_lock(&wss->bins_lock);
> +       memcpy(wss->bins, bins, sizeof(wss->bins));
> +       WRITE_ONCE(wss->refresh_threshold, msecs_to_jiffies(refresh_thres=
hold));
> +       WRITE_ONCE(wss->report_threshold, msecs_to_jiffies(report_thresho=
ld));
> +       mutex_unlock(&wss->bins_lock);
> +       return 0;
> +}
> +EXPORT_SYMBOL(register_wss_receiver);
> +
> +void unregister_wss_receiver(void *receiver)
> +{
> +       wss_receiver =3D NULL;
> +}
> +EXPORT_SYMBOL(unregister_wss_receiver);
> +
>  /*
>   * Add a shrinker callback to be called from the vm.
>   */
> @@ -4606,6 +4656,12 @@ void report_wss(struct pglist_data *pgdat, struct =
scan_control *sc)
>         refresh_wss(wss, memcg, pgdat, sc, 0);
>         WRITE_ONCE(wss->timestamp, jiffies);
>
> +       /* balloon driver subscribes to global memory reclaim */
> +       if (!cgroup_reclaim(sc) && wss_receiver) {
> +               pr_warn("Working Set Notify!");
> +               working_set_notify(wss_receiver, wss->bins);
> +       }
> +
>         mutex_unlock(&wss->bins_lock);
>
>         if (wss->notifier)
> @@ -4711,6 +4767,52 @@ void report_reaccess(struct lruvec *lruvec, struct=
 lru_gen_mm_walk *walk)
>         }
>  }
>
> +/* TODO: Replace with a proper registration interface, similar to shrink=
ers. */
> +bool working_set_request(struct pglist_data *pgdat)
> +{
> +       unsigned int flags;
> +       struct scan_control sc =3D {
> +               .may_writepage =3D true,
> +               .may_unmap =3D true,
> +               .may_swap =3D true,
> +               .reclaim_idx =3D MAX_NR_ZONES - 1,
> +               .gfp_mask =3D GFP_KERNEL,
> +       };
> +       struct wss *wss;
> +
> +       if (!wss_receiver)
> +               return false;
> +
> +       wss =3D lruvec_wss(mem_cgroup_lruvec(NULL, pgdat));
> +
> +       if (!mutex_trylock(&wss->bins_lock))
> +               return false;
> +
> +       if (wss->bins->idle_age !=3D -1) {
> +               unsigned long timestamp =3D READ_ONCE(wss->timestamp);
> +               unsigned long threshold =3D READ_ONCE(wss->refresh_thresh=
old);
> +
> +               if (time_is_before_jiffies(timestamp + threshold)) {
> +                       // We might need to refresh the report.
> +                       set_task_reclaim_state(current, &sc.reclaim_state=
);
> +                       flags =3D memalloc_noreclaim_save();
> +                       refresh_wss(wss, NULL, pgdat, &sc, threshold);
> +                       memalloc_noreclaim_restore(flags);
> +                       set_task_reclaim_state(current, NULL);
> +               }
> +       }
> +
> +       if (wss_receiver) {
> +               pr_warn("WS notify inside ws request\n");
> +               working_set_notify(wss_receiver, wss->bins);
> +       }
> +
> +       mutex_unlock(&wss->bins_lock);
> +       return true;
> +
> +}
> +EXPORT_SYMBOL(working_set_request);
> +
>  static struct pglist_data *kobj_to_pgdat(struct kobject *kobj)
>  {
>         int nid =3D IS_ENABLED(CONFIG_NUMA) ? kobj_to_dev(kobj)->id :
> --
> 2.40.1.521.gf1e218fcd8-goog
>
